require "bundler/gem_tasks"
require 'rake'
require 'rspec/core/rake_task'

desc 'Default: run server specs'
task :default => :server

desc "Run server specs"
RSpec::Core::RakeTask.new(:server) do |spec|
  spec.pattern = "./spec/*_spec.rb"
end