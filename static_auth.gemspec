# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'static_auth/version'

Gem::Specification.new do |spec|
  spec.name          = 'static_auth'
  spec.version       = StaticAuth::VERSION
  spec.authors       = ['Karl Turner']
  spec.email         = ['karl.turner5@gmail.com']
  spec.summary       = 'Help with authorising static web sites'
  spec.description   = 'Help with authorising static web sites only using middleman and gh auth for now'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'middleman'
  spec.add_runtime_dependency 'middleman-livereload', '~> 3.1.0', '>= 3.1.0'
  spec.add_runtime_dependency 'rack'
  spec.add_runtime_dependency 'omniauth'
  spec.add_runtime_dependency 'omniauth-github'
  spec.add_runtime_dependency 'sinatra'
  spec.add_runtime_dependency 'octokit'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
