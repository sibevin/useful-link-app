class OmniHandler::Base

  def code
    raise "Your Omni handler should implement this method."
  end

  def provider_id
    OmniHandler::HANDLER_MAP[code][:provider_id]
  end

  def get_account(authdata)
    authdata.info.email
  end

  def find_or_create_ref(authdata)
    uuid = authdata.uid
    if ref = find_ref_by_uuid(uuid)
      return ref
    else
      # create a new user
      begin
        user = nil
        ActiveRecord::Base.transaction do
          ref = OmniReference.new(:provider => provider_id,
                                  :uuid => uuid,
                                  :email => authdata.info.email,
                                  :account => get_account(authdata))
          name = "#{ENV['APP_CODE']}_#{code}_#{RandomToken.get(32)}"
          password = RandomToken.get(64)
          user = ref.create_user(:name => name,
                                 :email => "#{name}@#{ENV['APP_CODE']}.fakemail.com",
                                 :password => password,
                                 :password_confirmation => password)
          ref.save!
        end
        return ref
      rescue => e
        p e
        return nil
      end
    end
  end

  private

  def find_ref_by_uuid(uuid)
    OmniReference.where(['provider = ? AND uuid = ?', provider_id, uuid]).first
  end
end
