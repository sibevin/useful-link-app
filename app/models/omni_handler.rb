module OmniHandler
  HANDLER_MAP = {
    facebook: {
      provider_id: 1,
      display_name: 'Facebook'
    },
    twitter: {
      provider_id: 2,
      display_name: 'Twitter'
    },
    google: {
      provider_id: 3,
      display_name: 'Google'
    }
  }

  class << self
    def gen(code)
      case code
        when OmniHandler::Facebook.new.code
          return OmniHandler::Facebook.new
        when OmniHandler::Twitter.new.code
          return OmniHandler::Twitter.new
        when OmniHandler::Google.new.code
          return OmniHandler::Google.new
        else
          raise "Unknown Omni handler."
      end
    end
  end
end
