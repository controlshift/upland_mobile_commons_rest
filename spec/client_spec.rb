# frozen_string_literal: true

require 'spec_helper'

describe UplandMobileCommonsRest::Client do
  describe 'default_options' do
    it 'should set some defaults' do
      expect(subject.default_options[:user_agent]).to match(/ruby/)
      expect(subject.default_options[:host]).to eq('secure.mcommons.com')
    end
  end

  describe 'helpers' do
    it 'should return campaigns helper' do
      campaigns = subject.campaigns
      expect(campaigns).to be_a(UplandMobileCommonsRest::Campaigns)
      expect(campaigns.client).to eq(subject)
    end
  end

  describe 'error handling' do
    let(:request_params) { {example: 'data'} }

    subject { UplandMobileCommonsRest::Client.new(api_key: 'abcde-123456') }

    before :each do
      stub_request(:post, 'https://secure.mcommons.com/api/do_something')
        .to_return(status: response_status, body: response_body)
    end

    shared_examples_for 'error code parsing' do
      UplandMobileCommonsRest::TypedErrorMiddleware::POSSIBLE_ERRORS.each do |code, ex_type|
        context "response body with success=false and error code #{code}" do
          let(:response_body) do
            <<~XML
            <response success="false">
              <error id="#{code}" message="This is not correct!"/>
            </response>
            XML
          end

          it "should raise #{ex_type}" do
            expect{ subject.post_request('do_something', request_params) }.to raise_error(ex_type)
          end
        end
      end
    end

    context '200 status response' do
      let(:response_status) { 200 }

      context 'no response body' do
        let(:response_body) { nil }

        it 'should raise an UnknownError' do
          expect{ subject.post_request('do_something', request_params) }.to raise_error(UplandMobileCommonsRest::UnknownError)
        end
      end

      context 'response body without <response> tag' do
        let(:response_body) { '<body>Well, this is unexpected!</body>' }

        it 'should raise an UnknownError' do
          expect{ subject.post_request('do_something', request_params) }.to raise_error(UplandMobileCommonsRest::UnknownError)
        end
      end

      context 'response body with success=true' do
        let(:response_body) { '<response success="true">hurray!</response>' }

        it 'should not raise' do
          expect{ subject.post_request('do_something', request_params) }.not_to raise_error
        end
      end

      include_examples 'error code parsing'
    end

    context '400 status response' do
      let(:response_status) { 400 }

      include_examples 'error code parsing'
    end

    context '401 status response' do
      let(:response_status) { 401 }
      let(:response_body) { '<html><head><title>401 Unauthorized Error</title></head><body><center><h1>401 Unauthorized Error</h1></center></body></html>' }

      it 'should raise an UnauthorizedError' do
        expect do
          subject.post_request('do_something', request_params)
        end.to raise_error(UplandMobileCommonsRest::UnauthorizedError) do |error|
          expect(error.body).to eq response_body
          expect(error.to_s).to include(response_body)
        end
      end
    end

    context '502 status response' do
      let(:response_status) { 502 }
      let(:response_body) { '<html><head><title>502 Bad Gateway</title></head><body><center><h1>502 Bad Gateway</h1></center></body></html>' }

      it 'should raise an BadGatewayError' do
        expect do
          subject.post_request('do_something', request_params)
        end.to raise_error(UplandMobileCommonsRest::BadGatewayError) do |error|
          expect(error.body).to eq response_body
          expect(error.to_s).to include(response_body)
        end
      end
    end

    context '503 status response' do
      let(:response_status) { 503 }
      let(:response_body) { '<html><head><title>503 Internal Server Error</title></head><body><center><h1>503 Internal Server Error</h1></center></body></html>' }

      it 'should raise an UnknownError' do
        expect do
          subject.post_request('do_something', request_params)
        end.to raise_error(UplandMobileCommonsRest::UnknownError) do |error|
          expect(error.to_s).to include(response_body)
        end
      end

      context 'with Heavy Load message' do
        let(:response_body) { "<h2>This website is under heavy load (queue full)</h2><p>We're sorry, too many people are accessing this website at the same time. We're working on this problem. Please try again later.</p>" }

        it 'should raise a HeavyLoadError' do
          expect do
            subject.post_request('do_something', request_params)
          end.to raise_error(UplandMobileCommonsRest::HeavyLoadError) do |error|
            expect(error.to_s).to include(response_body)
          end
        end
      end

      context 'with Site Maintenance message' do
        let(:response_body) { "<title>Site Maintenance</title><p>Sorry for the inconvenience but we're performing some maintenance at the moment. If you need to you can always <a href=\"mailto:mc_support@uplandsoftware.com\">contact us</a>, otherwise we'll be back online shortly!</p>" }

        it 'should raise a SiteMaintenanceError' do
          expect do
            subject.post_request('do_something', request_params)
          end.to raise_error(UplandMobileCommonsRest::SiteMaintenanceError) do |error|
            expect(error.to_s).to include(response_body)
          end
        end
      end
    end

    context '504 status response' do
      let(:response_status) { 504 }
      let(:response_body) { '<html><head><title>504 Gateway Time-out</title></head><body><center><h1>504 Gateway Time-out</h1></center></body></html>' }

      it 'should raise an GatewayTimeoutError' do
        expect do
          subject.post_request('do_something', request_params)
        end.to raise_error(UplandMobileCommonsRest::GatewayTimeoutError) do |error|
          expect(error.body).to eq response_body
          expect(error.to_s).to include(response_body)
        end
      end
    end
  end
end
