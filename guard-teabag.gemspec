# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'guard/teabag/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name         = "guard-teabag"
  s.version      = Guard::TeabagVersion::VERSION
  s.authors      = ["jejacks0n"]
  s.email        = ["info@modeset.com"]
  s.homepage     = "https://github.com/modeset/guard-teabag"
  s.description  = "Guard-Teabag: Guard plugin for Teabag"
  s.summary      = "Run Javascript tests with Guard and all the features of Teabag"

  s.files        = Dir["{lib}/**/*"] + ["MIT.LICENSE", "README.md"]
  s.test_files   = Dir["{spec}/**/*"]
  s.require_path = "lib"

  s.add_dependency "guard"
  s.add_dependency "teabag"
end
