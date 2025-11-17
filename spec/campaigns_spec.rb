# frozen_string_literal: true

require 'spec_helper'

describe UplandMobileCommonsRest::Campaigns do
  let(:client) { UplandMobileCommonsRest::Client.new(api_key: 'abcde-123456') }

  subject { UplandMobileCommonsRest::Campaigns.new(client:) }

  it 'should initialize' do
    expect(subject.client).to eq(client)
  end

  context 'with credentials' do
    let(:api_key) { 'abcde-123456' }

    describe 'list' do
      let(:response_body) { fixture('campaigns/list.xml') }

      before(:each) do
        stub_upland_mobile_commons_request('campaigns', method: :get).to_return(status: 200, body: response_body)
      end

      it 'should return a list of campaigns' do
        list = subject.list
        expect(list).to be_a(Enumerable)
      end
    end
  end
end
