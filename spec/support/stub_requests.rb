# frozen_string_literal: true

def stub_upland_mobile_commons_request(path, method:, body: nil)
  stub_request(method, "https://secure.mcommons.com/api/#{path}")
    .with(body: body, headers: {'Authorization' => "Bearer #{api_key}"})
end
