source 'https://rubygems.org'

gemspec

gem "teabag"

# used by the dummy application
gem "rails", ">= 3.2.9"
gem "coffee-rails"

# used by test rails apps
gem "sqlite3"
gem "uglifier"
gem "sass-rails"
gem "jquery-rails"

# guard / used by guard
gem "rb-fsevent", require: false
gem "rb-inotify" if RUBY_PLATFORM =~ /linux/

group :development, :test do
  gem "rspec-rails"
  gem "capybara"
  gem "aruba"
end
