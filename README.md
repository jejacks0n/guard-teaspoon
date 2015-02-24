Guard-Teaspoon
==============

[![Gem Version](https://img.shields.io/gem/v/guard-teaspoon.svg)](https://rubygems.org/gems/guard-teaspoon)
[![Dependency Status](https://gemnasium.com/modeset/guard-teaspoon.png)](https://gemnasium.com/modeset/guard-teaspoon)
[![Build Status](https://img.shields.io/travis/modeset/guard-teaspoon.svg)](https://travis-ci.org/modeset/guard-teaspoon)
[![Code Climate](https://codeclimate.com/github/modeset/guard-teaspoon/badges/gpa.svg)](https://codeclimate.com/github/modeset/guard-teaspoon)
[![Test Coverage](https://codeclimate.com/github/modeset/guard-teaspoon/badges/coverage.svg)](https://codeclimate.com/github/modeset/guard-teaspoon)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

<img src="https://raw.github.com/modeset/teaspoon/master/screenshots/logo_big.png" alt="Logo by Morgan Keys" align="right" />
<sup>Logo by [Morgan Keys](http://www.morganrkeys.com/)</sup>

Guard-Teaspoon allows you to run [Teaspoon](https://github.com/modeset/teaspoon) using [Guard](https://github.com/guard/guard).

We recommend you first check out the [installation steps for Teaspoon](https://github.com/modeset/teaspoon#installation), and [read about the configuration](https://github.com/modeset/teaspoon#configuration).

[![Join the chat at https://gitter.im/modeset/teaspoon](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/modeset/teaspoon?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

With Guard-Teaspoon you can start up Guard, make changes to your tests or implementation files, and the specs will be run automatically using Teaspoon. It behaves very similarly to guard-rspec.

This project is still experimental, but is being worked on.


## Table of Contents

1. [Installation](#installation)
2. [Usage](#usage)
3. [Configuring Guard](#configuring-guard)


## Installation

Add it to your Gemfile. Like Teaspoon, in most cases you'll want to restrict it to the `:development, :test` groups.

```ruby
group :development, :test do
  gem "guard-teaspoon"
end
```

Install Teaspoon using the install generator.

```
rails generate teaspoon:install
```

Generate the Guardfile that includes the standard Guard-Teaspoon template.

```
bundle exec guard init teaspoon
```


## Usage

Start Guard.

```
bundle exec guard start
```

Make changes to your javascript specs or implementation files and the appropriate tests will run.


## Configuring Guard

In general this isn't very complicated, but if you have multiple suites setup in Teaspoon this can get a little complicated -- there's an expectation that you understand what you're doing in regards to using Guard.

The default Guardfile will watch for any file changes within your `app/assets/javascripts` path and will attempt to resolve those file to a spec. If you're using QUnit, you can change this to be `_test` instead of `_spec`, or use js.coffee or coffee for file extensions, and you can use a more advanced regexp for other needs.

Guardfile
```ruby
guard :teaspoon do
  watch(%r{^app/assets/javascripts/(.+).js}) { |m| "#{m[1]}_spec" }
  watch(%r{^spec/javascripts/(.*)})
end
```

### Specifying Teaspoon Environment

Guard-Teaspoon takes several options, but worth calling out is the environment option. This option allows you to tell Teaspoon where it should look for it's environment file, and is useful if Teaspoon is unable to resolve it's environment.

Guardfile
```ruby
guard :teaspoon, environment: "spec/dummy/spec/teaspoon_env.rb" do
end
```

### Available Options

...document when this is better hammered out...


## License

Licensed under the [MIT License](http://creativecommons.org/licenses/MIT/)

Copyright 2014 [Mode Set](https://github.com/modeset)


## Make Code Not War
![crest](https://secure.gravatar.com/avatar/aa8ea677b07f626479fd280049b0e19f?s=75)

