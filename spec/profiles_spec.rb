# frozen_string_literal: true

require 'spec_helper'

describe UplandMobileCommonsRest::Profiles do
  let(:client) { UplandMobileCommonsRest::Client.new(username: 'username', password: 'password') }

  subject { UplandMobileCommonsRest::Profiles.new(client: client) }

  it 'should initialize' do
    expect(subject.client).to eq(client)
  end

  context 'with credentials' do
    let(:username) { 'username' }
    let(:password) { 'password' }
    let(:phone_number) { '123-256-7890' }

    describe 'get' do
      before(:each) do
        stub_upland_mobile_commons_request("profile?phone_number=#{phone_number}", method: :get)
          .to_return(status: 200, body: response_body)
      end

      context 'success' do
        let(:response_body) { fixture('profiles/get.xml') }

        it 'should return profile data' do
          resp = subject.get(phone_number)
          expect(resp).to_not be_nil
          expect(resp['first_name']).to eq('John')
          expect(resp['last_name']).to eq('Doe')
          expect(resp['phone_number']).to eq('12025551234')
          expect(resp['id']).to eq('34xxxxxxx')
        end
      end

      context 'error' do
        let(:response_body) { fixture('error_profile_not_found.xml') }

        it 'should return nil and not raise' do
          resp = subject.get(phone_number)
          expect(resp).to be_nil
        end
      end
    end

    describe 'update' do
      before(:each) do
        stub_upland_mobile_commons_request('profile_update', method: :post, body: "phone_number=#{phone_number}")
          .to_return(status: 200, body: response_body)
      end

      context 'success' do
        let(:response_body) { fixture('profiles/update.xml') }

        it 'should succeed' do
          resp = subject.update(phone_number: phone_number)
          expect(resp).to_not be_nil

          expect(resp.body['response']['profile']['id']).to eq('34xxxxxxx')
          expect(resp.body['response']['profile']['first_name']).to eq('John')
          expect(resp.body['response']['profile']['last_name']).to eq('Doe')
        end
      end

      context 'error' do
        let(:response_body) { fixture('error.xml') }

        it 'should raise' do
          expect do
            subject.update(phone_number: phone_number)
          end.to raise_error(UplandMobileCommonsRest::InvalidMessageBody)
        end
      end
    end
  end
end
