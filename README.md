# StaticAuth

This will attempt to secure your static generated files via github.
You will need to setup:

  - GITHUB_KEY
  - GITHUB_SECRET
  - GITHUB_TEAM_ID (Used to make sure user is part of team)

## Installation

Add this line to your application's Gemfile:

    gem 'static_auth'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install static_auth

## Usage (Rack based application using TryStatic)

Can put this into your config.ru

```

# Setup github config and team
StaticAuth::Config.github_team_id = ENV['GITHUB_TEAM_ID'].to_i
StaticAuth::Config.github_key = ENV['GITHUB_KEY']
StaticAuth::Config.github_secret = ENV['GITHUB_SECRET']

# Build the static site when the app boots
StaticAuth::Cli::Commands.build_middleman

#Use auth for site
use StaticAuth::SinatraAuth

```

You will also need a config.rb file in root dir  
(Basic middleman config)


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
