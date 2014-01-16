class OmniHandler::Twitter < OmniHandler::Base
  def code
    :twitter
  end

  # use twitter nickname instead because no email is provided
  def get_account(authdata)
    '@' + authdata.info.nickname
  end
end
