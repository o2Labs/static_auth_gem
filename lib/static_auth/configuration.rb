module StaticAuth
  # Config file
  module Config
    class << self
      attr_accessor :github_key
      attr_accessor :github_secret
      attr_accessor :github_team_id
      attr_accessor :development_auth
    end
  end
end
