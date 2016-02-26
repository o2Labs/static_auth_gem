require 'spec_helper'
require 'rack/test'

describe 'StaticAuth' do
  context 'When using cli commands (middleman)' do
    before(:each) do
      @middle_man = double('Middleman')
      allow(Middleman::Cli::Build).to receive(:new).and_return(@middle_man)
      allow(@middle_man).to receive(:build).and_return(true)
    end

    it 'should build middleman' do
      expect(@middle_man).to receive(:build).once
      StaticAuth::Cli::Commands.build_middleman
    end
  end

  context 'When setting configuration' do
    it 'should set a config variable' do
      StaticAuth::Config.github_key = 'testkey'
      StaticAuth::Config.github_secret = 'testsecret'
      StaticAuth::Config.github_team_id = '1234'
      expect(StaticAuth::Config.github_key).to eq('testkey')
      expect(StaticAuth::Config.github_secret).to eq('testsecret')
      expect(StaticAuth::Config.github_team_id).to eq('1234')
    end
  end

  context 'When using sinatra module' do
    include Rack::Test::Methods

    def app
      StaticAuth::SinatraAuth
    end

    it 'should enforce security when development and set' do
      StaticAuth::Config.development_auth = true
      ENV['RACK_ENV'] = 'development'
      get '/'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.url).to eql('http://example.org/auth/github')
    end

    it 'should enforce security when production and not set' do
      StaticAuth::Config.development_auth = false
      ENV['RACK_ENV'] = 'production'
      get '/'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.url).to eql('http://example.org/auth/github')
    end

    it 'should not enforce security when development and not set' do
      StaticAuth::Config.development_auth = false
      ENV['RACK_ENV'] = 'development'
      get '/'
      expect(last_response.status).to eq(404)
    end
  end
end
