Guard Teabag
============
[![Build Status](https://travis-ci.org/modeset/guard-teabag.png)](https://travis-ci.org/modeset/guard-teabag)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/modeset/guard-teabag)

Guard-Teabag allows you to run the [Teabag test runner](https://github.com/modeset/teabag) using [Guard](https://github.com/guard/guard).

Teabag is a Javascript test runner built on top of Rails. It can run tests in the browser, or headlessly using PhantomJS or with Selenium WebDriver.

With Guard-Teabag you can start up Guard, make changes to your tests or implementation files, and the specs will be run automatically. It behaves very similarly to guard-rspec.

This project is still experimental...

## Table of Contents

1. [Installation](#installation)
2. [Usage](#usage)
3. [Configuring Guard](#configuring-guard)


## Installation

Add it to your Gemfile. Like Teabag, in most cases you'll want to restrict it to the `:asset`, or `:development, :test` groups.

```ruby
group :assets do
  gem "teabag"
  gem "guard-teabag"
  gem "rb-fsevent" # used by guard
end
```

You may also want to include one of the filesystem gems that [Guard suggests](https://github.com/guard/guard#efficient-filesystem-handling), and in our example we included the OS X `rb-inotify`.

We recommend you check out the [installation steps for Teabag](https://github.com/modeset/teabag#installation), and [read about configuration](https://github.com/modeset/teabag#configuration), but basically it boils down to running the generator.

```
rails generate teabag:install
```

Generate the Guardfile that includes the standard Guard-Teabag template.

```
bundle exec guard init
```


## Usage

To start Guard:

```
bundle exec guard start
```

Make changes to your javascript specs or implementation files and see the tests run.


## Configuring Guard

In general this isn't very complicated, but if you have multiple suites setup in Teabag this can get a little complicated -- there's an expectation that you understand what you're doing in regards to using Guard.

This is what the basic Guardfile looks like. It watches any file within your `app/assets/javascripts` path by default and will attempt to resolve the file to a spec. If you're using QUnit, you can change this to be _test instead of _spec, and you can use a more advanced regexp for other needs.

Guardfile
```ruby
guard :teabag do
  watch(%r{app/assets/javascripts/(.+).js}) { |m| "#{m[1]}_spec" }
  watch(%r{/spec/javascripts/(.*)})
end
```

### Specifying Teabag Environment

Guard-Teabag takes several options, but worth calling out is the environment option. This option allows you to tell Teabag where it should look for it's environment file, and is useful if Teabag is unable to resolve it's environment.

Guardfile
```ruby
guard :teabag, environment: "spec/dummy/spec/teabag_env.rb" do
end
```


## License

Licensed under the [MIT License](http://creativecommons.org/licenses/MIT/)

Copyright 2012 [Mode Set](https://github.com/modeset)


## Make Code Not War
![crest](https://secure.gravatar.com/avatar/aa8ea677b07f626479fd280049b0e19f?s=75)

