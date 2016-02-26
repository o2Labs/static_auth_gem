# Main Gem module
module StaticAuth
  # Using a sinatra piece for authentication
  class SinatraAuth < Sinatra::Base
    enable :sessions
    set :sessions, expire_after: 3600
    # Enable proper HEAD responses
    use Rack::Head

    use OmniAuth::Builder do
      provider :github,
               StaticAuth::Config.github_key,
               StaticAuth::Config.github_secret,
               scope: 'repo'
    end

    helpers do
      def octokit_client(token)
        Octokit::Client.new(
          access_token: token
        )
      end

      def dev_auth_setting
        StaticAuth::Config.development_auth
      end

      def dev_auth_set
        return true if environment == 'production'
        dev_auth_setting == true && environment == 'development'
      end

      def team_id
        StaticAuth::Config.github_team_id
      end

      def member?(screen_name, token)
        return false unless screen_name && token
        octokit_client(token).team_member?(team_id, screen_name)
      end

      def environment
        ENV['RACK_ENV']
      end

      def callback_path
        '/auth/github/callback'
      end

      def fail_path
        '/auth/failure'
      end
    end

    before do
      # Check for session.
      confirmed = session[:confirmed_user]
      unless request.path_info == (callback_path || fail_path) || !dev_auth_set
        return redirect '/auth/github' if confirmed.nil?
      end
      return
    end

    get '/auth/failure' do
      return halt(params[:message])
    end

    get '/auth/github/callback' do
      return halt(
        'issue with auth'
      ) unless env['omniauth.auth'].extra.raw_info.login
      return halt(
        'issue with auth'
      ) unless env['omniauth.auth'].credentials.token
      screen_name = env['omniauth.auth'].extra.raw_info.login
      token = env['omniauth.auth'].credentials.token
      return halt('Not Authorised') unless member?(screen_name, token)
      session[:confirmed_user] = env['omniauth.auth'].extra.raw_info.login
      puts "authenticated user: #{screen_name}"
      redirect '/'
    end
  end
end
