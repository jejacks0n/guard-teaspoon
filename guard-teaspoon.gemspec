# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'guard/teaspoon/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name         = "guard-teaspoon"
  s.version      = Guard::TeaspoonVersion::VERSION
  s.authors      = ["jejacks0n"]
  s.email        = ["info@modeset.com"]
  s.homepage     = "https://github.com/modeset/guard-teaspoon"
  s.description  = "Guard-Teaspoon: Guard plugin for Teaspoon"
  s.summary      = "Run Javascript tests with Guard and all the features of Teaspoon"

  s.files        = Dir["{lib}/**/*"] + ["MIT.LICENSE", "README.md"]
  s.test_files   = Dir["{spec}/**/*"]
  s.require_path = "lib"

  s.add_dependency "guard", ">= 1.6.1"
  s.add_dependency "teaspoon", ">= 0.5.3"
end
