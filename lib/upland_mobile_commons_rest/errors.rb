# frozen_string_literal: true

module UplandMobileCommonsRest
  class NetworkError < StandardError; end
  class BadGatewayError < NetworkError; end
  class GatewayTimeoutError < NetworkError; end

  class MobileCommonsError < StandardError
    attr_accessor :code, :raw_message
  end

  class UnknownError < MobileCommonsError; end

  class InvalidCampaignId < MobileCommonsError; end

  class InvalidBroadcastTime < MobileCommonsError; end

  class InvalidMessageBody < MobileCommonsError; end

  class InvalidCompanyId < MobileCommonsError; end

  class InvalidPhoneNumber < MobileCommonsError; end

  class InvalidGroupId < MobileCommonsError; end

  class InvalidStartTime < MobileCommonsError; end

  class InvalidEndTime < MobileCommonsError; end

  class InvalidMdataId < MobileCommonsError; end

  class InvalidKey < MobileCommonsError; end

  class PhoneIsNotOptedIntoThisCampaign < MobileCommonsError; end

  class InvalidFundraisingId < MobileCommonsError; end

  class InvalidMessageTemplate < MobileCommonsError; end

  class PhoneIsNotTextable < MobileCommonsError; end

  class InvalidMconnectId < MobileCommonsError; end

  class InvalidQueryParameters < MobileCommonsError; end

  class TooManyMessages < MobileCommonsError; end

  class InvalidName < MobileCommonsError; end

  class InvalidOptInPath < MobileCommonsError; end

  class InvalidUrl < MobileCommonsError; end

  class InvalidAttachment < MobileCommonsError; end

  class InvalidBroadcastId < MobileCommonsError; end

  class InvalidBroadcastStateChange < MobileCommonsError; end

  class BroadcastHasNotBeenSent < MobileCommonsError; end

  class MessageTemplateInvalid < MobileCommonsError; end

  class InvalidUserId < MobileCommonsError; end

  class APIRateLimitExceeded < MobileCommonsError; end

  class MissingPhoneNumberParameter < MobileCommonsError; end

  class InvalidProfileSaveItemBehavior < MobileCommonsError; end

  class InvalidProfileAttributes < MobileCommonsError; end

  class InvalidPreviousId < MobileCommonsError; end

  class InvalidTagName < MobileCommonsError; end

  class InvalidTagParameters < MobileCommonsError; end

  class InvalidShortcodeId < MobileCommonsError; end

  class InvalidDateRange < MobileCommonsError; end

  class InvalidScheduledMessageId < MobileCommonsError; end

  class MessageHasAlreadyBeenSent < MobileCommonsError; end

  class TypedErrorMiddleware < Faraday::Response::Middleware
    POSSIBLE_ERRORS = {
      '0' => UnknownError,
      '1' => InvalidCampaignId,
      '2' => InvalidBroadcastTime,
      '3' => InvalidMessageBody,
      '4' => InvalidCompanyId,
      '5' => InvalidPhoneNumber,
      '6' => InvalidGroupId,
      '7' => InvalidStartTime,
      '8' => InvalidEndTime,
      '9' => InvalidMdataId,
      '10' => InvalidKey,
      '11' => PhoneIsNotOptedIntoThisCampaign,
      '12' => InvalidFundraisingId,
      '13' => InvalidMessageTemplate,
      '14' => PhoneIsNotTextable,
      '15' => InvalidMconnectId,
      '16' => InvalidQueryParameters,
      '17' => TooManyMessages,
      '18' => InvalidName,
      '19' => InvalidOptInPath,
      '20' => InvalidUrl,
      '21' => InvalidAttachment,
      '22' => InvalidBroadcastId,
      '23' => InvalidBroadcastStateChange,
      '24' => BroadcastHasNotBeenSent,
      '25' => MessageTemplateInvalid,
      '26' => InvalidUserId,
      '27' => APIRateLimitExceeded,
      '28' => MissingPhoneNumberParameter,
      '29' => InvalidProfileSaveItemBehavior,
      '30' => InvalidProfileAttributes,
      '31' => InvalidPreviousId,
      '32' => InvalidTagName,
      '33' => InvalidTagParameters,
      '34' => InvalidShortcodeId,
      '35' => InvalidDateRange,
      '36' => InvalidScheduledMessageId,
      '37' => MessageHasAlreadyBeenSent
    }.freeze

    def on_complete(response)
      status_code = response[:status].to_i

      case status_code
      when 200...500
        # I'm not sure if responses with error codes have status 200 or 400-499,
        # so just to be safe, handle all of those.

        # First ensure responses without the expected format are correctly handled
        raise UnknownError, response.inspect if response.body.nil? || response.body['response'].nil?

        # Now verify that response was successful or raise a corresponding exception otherwise
        if response.body['response']['success'] == 'false'
          raise POSSIBLE_ERRORS[response.body['response']['error']['id']], response.body['response']['error']['message']
        end
      when 502
        raise BadGatewayError
      when 504
        raise GatewayTimeoutError
      when 500...600
        # Just in case we get other 5xx errors, raise something for those
        # This has not happened that we know of, but better safe than sorry!
        raise UnknownError, response.inspect
      end
    end
  end
end
