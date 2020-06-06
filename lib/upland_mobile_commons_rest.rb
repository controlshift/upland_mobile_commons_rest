require 'vertebrae'

module UplandMobileCommonsRest
  extend Vertebrae::Base

  class << self
    def new(options = {})
      UplandMobileCommonsRest::Client.new(options)
    end
  end
end

require 'upland_mobile_commons_rest/client'