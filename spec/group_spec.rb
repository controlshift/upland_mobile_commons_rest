require 'spec_helper'

describe UplandMobileCommonsRest::Groups do
  let(:client) { UplandMobileCommonsRest::Client.new(username: 'username', password: 'password') }

  subject { UplandMobileCommonsRest::Groups.new(client: client) }

  it 'should initialize' do
    expect(subject.client).to eq(client)
  end

  context 'with credentials' do
    let(:username) { 'username' }
    let(:password) { 'password' }

    describe 'list' do
      let(:response_body) { fixture('groups/list.xml') }

      before(:each) do
        stub_upland_mobile_commons_request('groups', method: :get).to_return(status: 200, body: response_body)
      end

      it 'should return a list of groups' do
        list = subject.list
        expect(list).to be_a(Enumerable)
        expect(list).to eq([{"id"=>"14", "name"=>"Group One", "size"=>"2", "status"=>"active", "type"=>"FilteredGroup"},
                            {"id"=>"91", "name"=>"Group Two", "size"=>"1", "status"=>"active", "type"=>"UploadedGroup"}])
      end
    end

    describe 'create' do
      let(:response_body) { fixture('groups/create.xml') }

      before(:each) do
        stub_upland_mobile_commons_request('create_group?name=Chocolate%20Lovers', method: :get).to_return(status: 200, body: response_body)
      end

      it 'should return success' do
        resp = subject.create('Chocolate Lovers')
        expect(resp.body['response']['success']).to be_truthy
      end
    end
  end
end