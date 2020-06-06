
require 'spec_helper'

describe UplandMobileCommonsRest do
  it 'returns a client' do
    client = UplandMobileCommonsRest.new(username: 'foo', password: 'bar')
    expect(client).to be_an_instance_of(UplandMobileCommonsRest::Client)
    expect(client.username).to eq('foo')
    expect(client.password).to eq('bar')
  end
end