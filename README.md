Guard Teabag
============
[![Build Status](https://travis-ci.org/modeset/guard-teabag.png)](https://travis-ci.org/modeset/guard-teabag)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/modeset/guard-teabag)

Guard-Teabag allows you to run the [Teabag test runner](https://github.com/modeset/teabag) using Guard. Teabag is a Javascript test runner built on top of Rails. It can run tests in the browser, or headlessly using PhantomJS or with Selenium WebDriver.

With Guard-Teabag you can start up Guard, make changes to your tests or implementation files, and the specs will be run automatically. It behaves very similarly to guard-rspec.

## Table of Contents

1. [Installation](#installation)
2. [Usage](#usage)
3. [Configuring Guard](#configuring-guard)


## Installation

Add it to your Gemfile. Like Teabag, in most cases you'll want to restrict it to the `:asset`, or `:development, :test` groups.

```ruby
group :assets do
  gem "guard-teabag"
end
```

Guard-Teabag has a dependency on Teabag, so it will be installed as well. We recommend you check out the installation
steps, and configuration for Teabag as well, but basically it boils down to running the generator.

```
rails generate teabag:install
```

Generate the Guardfile that includes the standard Guard-Teabag template.

```
bundle exec guard init
```


## Usage

To start guard:

```
bundle exec guard start
```

Make changes to your javascript specs or implementation files and see the tests run.


## Configuring Guard

In general this isn't very complicated, but if you have multiple suites setup in Teabag this can get a little complicated. There's an expectation that you understand what you're doing in regards to using Guard.

Here's the Guardfile that this project uses. Since we don't have a standard setup you can see that we have to manually tell Teabag where to find it's environment file.

```ruby
guard :teabag, environment: "spec/dummy/spec/teabag_env.rb" do
  root = "spec/dummy"

  # Your implementation files
  watch(%r{#{root}/app/assets/javascripts/(nested/.+).coffee}) { |m| "#{m[1]}_tspec" }
  watch(%r{#{root}/app/assets/javascripts/(.+).js}) { |m| "#{m[1]}_spec" }

  # Jasmine/Mocha
  watch(%r{#{root}/spec/javascripts/(.*)})

  # QUnit
  #watch(%r{#{root}/test/javascripts/(.*)})
end
```
