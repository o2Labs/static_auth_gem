require 'rspec'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'static_auth'

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
Dir[File.join(APP_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end
