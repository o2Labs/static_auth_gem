require 'spec_helper'
require 'rack/test'

describe 'StaticAuth' do

  context 'When using cli commands (middleman)' do
    before(:each) do
      @middle_man = double('Middleman')
      Middleman::Cli::Build.stub(:new).and_return(@middle_man)
    end

    it 'should build middleman' do
      @middle_man.should_receive(:build).once
      StaticAuth::Cli::Commands.build_middleman
    end
  end

  context 'When setting configuration' do
    it 'should set a config variable' do
      StaticAuth::Config.github_key = 'testkey'
      StaticAuth::Config.github_secret = 'testsecret'
      StaticAuth::Config.github_team_id = '1234'
      StaticAuth::Config.github_key.should eq('testkey')
      StaticAuth::Config.github_secret.should eq('testsecret')
      StaticAuth::Config.github_team_id.should eq('1234')
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
      last_response.should be_redirect
      follow_redirect!
      last_request.url.should eq('http://example.org/auth/github')
    end

    it 'should not enforce security when development and not set' do
      StaticAuth::Config.development_auth = false
      ENV['RACK_ENV'] = 'development'
      get '/'
      last_response.status.should eq(404)
    end
  end
end
