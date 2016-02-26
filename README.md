# StaticAuth

This will attempt to secure your static generated files via github.
You will need to setup:

  - GITHUB_KEY ( in settings/applications with github - Developer applications)
  - GITHUB_SECRET ( in settings/applications with github - Developer applications)
  - GITHUB_TEAM_ID (Used to make sure user is part of team)

Also in settings/applications with github - Developer applications
`Authorization callback URL`: http://your.server/auth/github/callback

## Installation

Add this line to your application's Gemfile:

    gem 'static_auth', git: 'git@github.com:o2Labs/static_auth_gem.git'

And then execute:

    $ bundle

## Usage (Rack based application using TryStatic)

###Example config.ru

```

# Setup github config and team
StaticAuth::Config.github_team_id = ENV['GITHUB_TEAM_ID'].to_i
StaticAuth::Config.github_key = ENV['GITHUB_KEY']
StaticAuth::Config.github_secret = ENV['GITHUB_SECRET']

## Can use this for running in development without auth
StaticAuth::Config.development_auth = false

# Use session cookies
use Rack::Session::Cookie, secret: 'YourSecret'
use Rack::Session::Pool

#Use auth for site
use StaticAuth::SinatraAuth

```


###Using MiddleMan?

You will also need to add the below to the config.ru:

```

# Build the static site when the app boots
StaticAuth::Cli::Commands.build_middleman

```

Create a config.rb file in app root dir.


```

set :css_dir, 'assets/stylesheets'

set :js_dir, 'assets/javascripts'

set :images_dir, 'assets/images'

set :build_dir, 'site'

configure :build do

end

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/static_auth/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
