require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

$LOAD_PATH << File.dirname(__FILE__) unless $LOAD_PATH.include?(File.dirname(__FILE__))

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = "-c -f d"
end

Cucumber::Rake::Task.new
