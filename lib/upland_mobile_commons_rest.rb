# frozen_string_literal: true

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
require 'upland_mobile_commons_rest/base'
require 'upland_mobile_commons_rest/campaigns'
require 'upland_mobile_commons_rest/groups'
require 'upland_mobile_commons_rest/profiles'
require 'upland_mobile_commons_rest/errors'