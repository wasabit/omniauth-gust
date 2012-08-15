require 'spec_helper'
require 'omniauth-gust'

# Based on tests from https://github.com/mkdynamic/omniauth-facebook
describe OmniAuth::Strategies::Gust do
  before :each do
    @request = double('Request')
    @request.stub(:params) { {} }
    @request.stub(:cookies) { {} }
    
    @client_id = '123'
    @client_secret = 'aaa'
  end
  
  subject do
    args = [@client_id, @client_secret, @options].compact
    OmniAuth::Strategies::Gust.new(nil, *args).tap do |strategy|
      strategy.stub(:request) { @request }
    end
  end

  it_should_behave_like 'an oauth2 strategy'

  describe '#client' do
    it 'has correct Gust site' do
      subject.client.site.should eq('https://alpha.gust.com')
    end

    it 'has correct authorize url' do
      subject.client.options[:authorize_url].should eq('/r/oauth/authorize')
    end

    it 'has correct token url' do
      subject.client.options[:token_url].should eq('/r/oauth/token')
    end
  end

  describe '#uid' do
    before :each do
      subject.stub(:raw_info) { { 'id' => '123' } }
    end

    it 'returns the id from raw_info' do
      subject.uid.should eq('123')
    end
  end

  describe '#info' do
    before :each do
      @raw_info ||= { 'user_name' => 'sebas' }
      subject.stub(:raw_info) { @raw_info }
    end

    context 'when data is present in raw info' do

      it 'returns the username as name' do
        @raw_info['username'] = 'sebas'
        subject.info['name'].should eq('sebas')
      end

      it 'returns email as email' do
        @raw_info['email'] = 'sebas@foob.ar'
        subject.info['email'].should eq('sebas@foob.ar')
      end

      it 'returns company_name as company_name' do
        @raw_info['company_name'] = 'wasabit'
        subject.info['company_name'].should eq('wasabit')
      end

      it 'returns the Gust profile page link as the Gust url' do
        @raw_info['profile_url'] = 'https://alpha.gust.com/c/wasabit'
        subject.info['urls'].should be_a(Hash)
        subject.info['urls']['profile'].should eq('https://alpha.gust.com/c/wasabit')
      end

    end
  end

  describe '#raw_info' do
    before :each do
      @access_token = double('OAuth2::AccessToken')
      subject.stub(:access_token) { @access_token }
    end

    it 'performs a GET to https://alpha.gust.com/r/oauth/user_details' do
      @access_token.stub(:get) { double('OAuth2::Response').as_null_object }
      @access_token.should_receive('options')
      @access_token.should_receive(:get).with('/r/oauth/user_details')
      subject.raw_info
    end

    it 'returns a Hash' do
      @access_token.should_receive(:options)
      @access_token.stub(:get).with('/r/oauth/user_details') do
        raw_response = double('Faraday::Response')
        raw_response.stub(:body) { '{ "foo": "bar" }' }
        raw_response.stub(:status) { 200 }
        raw_response.stub(:headers) { { 'Content-Type' => 'application/json' } }
        OAuth2::Response.new(raw_response)
      end
      subject.raw_info.should be_a(Hash)
      subject.raw_info['foo'].should eq('bar')
    end
  end

end
