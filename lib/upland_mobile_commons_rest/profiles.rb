# frozen_string_literal: true

module UplandMobileCommonsRest
  class Profiles < Base
    def base_path
      'profile'
    end

    def get(phone_number)
      resp = client.get_request("#{base_path}?phone_number=#{CGI.escape(phone_number)}")
      resp.body['response']['profile']
    # API returns error id '5' (invalid phone number) when profile with phone number is not found
    rescue UplandMobileCommonsRest::InvalidPhoneNumber
      nil
    end

    def update(params)
      client.post_request('profile_update', params)
    end
  end
end
