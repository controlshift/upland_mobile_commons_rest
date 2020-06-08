# frozen_string_literal: true

module UplandMobileCommonsRest
  class Client < Vertebrae::API
    attr_accessor :username, :password, :company_key

    def initialize(options={}, &block)
      self.username = options[:username]
      self.password = options[:password]
      self.company_key = options[:company_key]
      super(options, &block)
    end

    def default_options
      {
        host: 'secure.mcommons.com',
        prefix: '/api',
        user_agent: 'ruby: UplandMobileCommonsRest',
        content_type: 'application/xml',
        additional_headers: {
          'Accept' => 'application/xml'
        }
      }
    end

    def setup
      connection.stack do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        if connection.configuration.authenticated?
          builder.use Faraday::Request::BasicAuthentication, connection.configuration.username, connection.configuration.password
        end

        builder.use Faraday::Response::Logger if ENV['DEBUG']
        builder.use FaradayMiddleware::ParseXml

        builder.adapter connection.configuration.adapter
      end
    end

    ## Helper functions to let consumers do things like `client.campaigns.list`

    def campaigns
      @_campaigns ||= UplandMobileCommonsRest::Campaigns.new(client: self)
    end
  end
end
