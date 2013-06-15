guard :teaspoon, environment: "spec/dummy/spec/teaspoon_env.rb" do
  root = "spec/dummy"

  # Your implementation files
  watch(%r{#{root}/app/assets/javascripts/(nested/.+).coffee}) { |m| "#{m[1]}_tspec" }
  watch(%r{#{root}/app/assets/javascripts/(.+).js}) { |m| "#{m[1]}_spec" }

  # Jasmine/Mocha
  watch(%r{#{root}/spec/javascripts/(.*)})

  # QUnit
  #watch(%r{#{root}/test/javascripts/(.*)})
end
