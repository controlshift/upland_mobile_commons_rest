# frozen_string_literal: true

module UplandMobileCommonsRest
  class Client < Vertebrae::API
    attr_accessor :api_key

    def initialize(options = {}, &block)
      self.api_key = options.delete(:api_key)
      super(options, &block)
    end

    def default_options
      {
        host: 'secure.mcommons.com',
        prefix: '/api',
        user_agent: 'ruby: UplandMobileCommonsRest',
        content_type: 'application/x-www-form-urlencoded',
        additional_headers: {
          'Accept' => 'application/xml'
        }
      }
    end

    def setup
      connection.faraday_connection = Faraday.new(connection.configuration.faraday_options) do |f|
        # Request middlewares, in the order they should run
        f.request :multipart
        f.request :url_encoded
        f.request :authorization, 'Bearer', api_key

        # Response middlewares, in the *reverse* order they should run
        f.use UplandMobileCommonsRest::TypedErrorMiddleware
        f.response :logger if ENV['DEBUG']
        f.use UplandMobileCommonsRest::ParseXmlMiddleware
        f.use UplandMobileCommonsRest::HttpErrorMiddleware

        f.adapter connection.configuration.adapter
      end
    end

    def extract_data_from_params(params) # :nodoc:
      URI.encode_www_form(params)
    end

    ## Helper functions to let consumers do things like `client.campaigns.list`

    def campaigns
      @_campaigns ||= UplandMobileCommonsRest::Campaigns.new(client: self)
    end

    def groups
      @_groups ||= UplandMobileCommonsRest::Groups.new(client: self)
    end

    def profiles
      @_profiles ||= UplandMobileCommonsRest::Profiles.new(client: self)
    end
  end
end
