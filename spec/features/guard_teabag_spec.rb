require "spec_helper"

feature "Full setup of an app that can run guard-teabag", aruba: true do

  before do
    unset_bundler_env_vars
    run_simple("bundle exec rails new testapp --skip-bundle")
    cd("testapp")
    append_to_file("Gemfile", "gem 'teabag'" + "\n")
    append_to_file("Gemfile", "gem 'guard-teabag', path: '#{File.expand_path('../../../', __FILE__)}'" + "\n")
    append_to_file("Gemfile", "gem 'rb-fsevent'" + "\n")
    run_simple("bundle install --local")
  end

  scenario "installing Teabag and generating the Guardfile" do
    run_simple("bundle exec rails g teabag:install")
    check_file_presence(["config/initializers/teabag.rb"], true)
    check_file_presence(["spec/teabag_env.rb"], true)
    check_file_presence(["spec/javascripts/spec_helper.js"], true)

    run_simple("bundle exec guard init")
    assert_partial_output("INFO - teabag guard added to Guardfile, feel free to edit it", all_output)
    check_file_presence(["Guardfile"], true)
  end

  scenario "allows running guard and will notice file changes" do
    run_simple("bundle exec rails g teabag:install")
    run_simple("bundle exec guard init")

    write_file("app/assets/javascripts/test.js", "foo = 'something'")
    write_file "spec/javascripts/test_spec.js", <<-JAVASCRIPT
    // require application
    describe("Application", function() {
      it("tests", function() { expect(true).toBe(true) })
    });
    JAVASCRIPT

    run_interactive("bundle exec guard start")
    sleep 5
    `touch tmp/aruba/testapp/app/assets/javascripts/test.js`
    sleep 5
    type("exit")

    # the first time it runs
    assert_partial_output("Teabag running default suite at", all_output)

    # when the file has been modified
    assert_partial_output("/teabag/default/?file[]=", all_output)
    assert_partial_output("tmp/aruba/testapp/spec/javascripts/test_spec.js", all_output)
  end
end
