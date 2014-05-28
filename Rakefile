#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require './lib/static_auth'

namespace :build_site do
  task :middleman do
    StaticAuth::Cli::Commands.build_middleman
  end
end

RSpec::Core::RakeTask.new
task default: :spec
