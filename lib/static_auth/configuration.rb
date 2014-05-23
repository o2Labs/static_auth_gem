module StaticAuth
  # Config file
  module Config
    class << self
      attr_accessor :github_key
      attr_accessor :github_secret
      attr_accessor :github_team_id
    end
  end
end
