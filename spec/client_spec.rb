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
end
