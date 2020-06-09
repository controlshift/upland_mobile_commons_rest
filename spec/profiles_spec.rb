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

    describe 'update' do
      before(:each) do
        stub_upland_mobile_commons_request('profile_update', method: :post, body: 'phone_number=123-256-7890').
            to_return(status: 200, body: response_body)
      end

      context 'success' do
        let(:response_body) { fixture('profiles/update.xml') }

        it 'should succeed' do
          resp = subject.update(phone_number: '123-256-7890')
          expect(resp).to_not be_nil
        end
      end

      context 'error' do
        let(:response_body) { fixture('error.xml') }

        it 'should raise' do
          expect { subject.update(phone_number: '123-256-7890') }.to raise_error(UplandMobileCommonsRest::InvalidMessageBody)
        end
      end
    end
  end
end
