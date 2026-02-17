# frozen_string_literal: true

require 'multi_xml'

module UplandMobileCommonsRest
  # XML parser middleware for Faraday 2.x
  class ParseXmlMiddleware < Faraday::Middleware
    def on_complete(response)
      response[:body] = parse(response[:body]) if parse_response?(response)
    end

    private

    def parse(body)
      MultiXml.parse(body)
    rescue StandardError
      # Return the original body if parsing fails
      body
    end

    def parse_response?(response)
      response[:body].respond_to?(:to_str) && !response[:body].empty?
    end
  end
end
