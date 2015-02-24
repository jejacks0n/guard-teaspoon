require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

namespace :spec do
  desc "Run the code examples in spec/features"
  RSpec::Core::RakeTask.new("features") do |t|
    t.pattern = "./spec/features/**/*_spec.rb"
  end
end

task default: :spec
