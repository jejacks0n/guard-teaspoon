$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "guard/teaspoon/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "guard-teaspoon"
  s.version     = Guard::TeaspoonVersion::VERSION
  s.authors     = ["jejacks0n", "jayzes", "jedschneider"]
  s.email       = ["info@modeset.com"]
  s.homepage    = "https://rubygems.org/gems/guard-teaspoon"
  s.summary     = "Guard plugin for Teaspoon"
  s.description = "Guard::Teaspoon automatically runs your Javascript tests with all the features of Teaspoon."
  s.license     = "MIT"

  s.files       = Dir["{lib}/**/*"] + ["MIT.LICENSE", "README.md"]
  s.test_files  = `git ls-files -- {spec,test}/*`.split("\n")

  s.add_dependency "guard", "~> 2.2"
  s.add_dependency "teaspoon", ">= 0.8.0"
end
