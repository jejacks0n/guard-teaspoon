source "https://rubygems.org"

gemspec

gem "teaspoon", github: "modeset/teaspoon"

# used by the dummy application
gem "rails", ">= 4.0.0"
gem "coffee-rails"
gem "sass-rails"
gem "jquery-rails"

group :development, :test do
  gem "rspec-rails"
  gem "capybara"
  gem "aruba"
  gem "guard-compat", "~> 1.2"
end

# io services
gem "codeclimate-test-reporter", group: :test, require: nil
gem "rubocop", require: false
