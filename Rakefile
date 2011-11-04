require "bundler/gem_tasks"
require 'rake'
require 'rspec/core/rake_task'

desc 'Default: run server specs'
task :default => :all

desc "Run all specs"
RSpec::Core::RakeTask.new(:all) do |spec|
  spec.pattern = "./spec/*_spec.rb"
end