# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'guard/teaspoon/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'guard-teaspoon'
  s.version     = Guard::TeaspoonVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'
  s.authors     = ['jejacks0n']
  s.email       = ['info@modeset.com']
  s.homepage    = 'https://rubygems.org/gems/guard-teaspoon'
  s.summary     = 'Guard plugin for Teaspoon'
  s.description = 'Guard::Teaspoon automatically runs your Javascript tests with all the features of Teaspoon.'

  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency 'guard',    '~> 2.2'
  s.add_runtime_dependency 'teaspoon', '>= 0.7.7'

  s.files        = Dir['{lib}/**/*'] + ['MIT.LICENSE', 'README.md']
  s.test_files   = Dir['{spec}/**/*']
  s.require_path = 'lib'
end
