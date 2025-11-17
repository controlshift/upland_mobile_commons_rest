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
      connection.stack do |builder|
        # Request middlewares, in the order they should run
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Request::Authorization, 'Bearer', self.api_key

        # Response middlewares, in the *reverse* order they should run
        builder.use UplandMobileCommonsRest::TypedErrorMiddleware
        builder.use Faraday::Response::Logger if ENV['DEBUG']
        builder.use FaradayMiddleware::ParseXml
        builder.use UplandMobileCommonsRest::HttpErrorMiddleware

        builder.adapter connection.configuration.adapter
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
