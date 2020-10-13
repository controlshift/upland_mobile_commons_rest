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

      context 'unpaginated request' do
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

      context 'paginated request' do
        it 'should return a list of groups when both parameters provided' do
          stub_upland_mobile_commons_request('groups?limit=50&page=35', method: :get).to_return(status: 200, body: response_body)

          list = subject.list(page: 35, limit: 50)

          expect(list).to be_a(Enumerable)
          expect(list).to eq([{"id"=>"14", "name"=>"Group One", "size"=>"2", "status"=>"active", "type"=>"FilteredGroup"},
                              {"id"=>"91", "name"=>"Group Two", "size"=>"1", "status"=>"active", "type"=>"UploadedGroup"}])
        end

        it 'should return a list of groups when only limit parameter provided' do
          stub_upland_mobile_commons_request('groups?limit=50', method: :get).to_return(status: 200, body: response_body)

          list = subject.list(limit: 50)

          expect(list).to be_a(Enumerable)
          expect(list).to eq([{"id"=>"14", "name"=>"Group One", "size"=>"2", "status"=>"active", "type"=>"FilteredGroup"},
                              {"id"=>"91", "name"=>"Group Two", "size"=>"1", "status"=>"active", "type"=>"UploadedGroup"}])
        end

        it 'should return a list of groups when only page parameter provided' do
          stub_upland_mobile_commons_request('groups?page=35', method: :get).to_return(status: 200, body: response_body)

          list = subject.list(page: 35)

          expect(list).to be_a(Enumerable)
          expect(list).to eq([{"id"=>"14", "name"=>"Group One", "size"=>"2", "status"=>"active", "type"=>"FilteredGroup"},
                              {"id"=>"91", "name"=>"Group Two", "size"=>"1", "status"=>"active", "type"=>"UploadedGroup"}])
        end
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