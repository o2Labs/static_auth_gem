require 'middleman-core/profiling'
require 'middleman-core/cli'

module StaticAuth
  module Cli
    # basic cli commands
    class Commands
      def self.build_middleman
        middleman_client.build
      end

      def self.middleman_client
        @middleman_client ||= Middleman::Cli::Build.new
      end
    end
  end
end
