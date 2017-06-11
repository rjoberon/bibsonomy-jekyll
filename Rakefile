require "bundler/gem_tasks"

# tests are in spec directory
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec

rescue LoadError
end
