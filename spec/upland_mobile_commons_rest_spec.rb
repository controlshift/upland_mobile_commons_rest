# frozen_string_literal: true

require 'spec_helper'

describe UplandMobileCommonsRest do
  it 'returns a client' do
    client = UplandMobileCommonsRest.new(api_key: 'abcde-123456')
    expect(client).to be_an_instance_of(UplandMobileCommonsRest::Client)
    expect(client.api_key).to eq('abcde-123456')
  end
end
