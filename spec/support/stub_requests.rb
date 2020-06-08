def stub_upland_mobile_commons_request(path, method:, body: nil)
  stub_request(method, "https://secure.mcommons.com/api/#{path}")
      .with(body: body, basic_auth: [username, password])
end
