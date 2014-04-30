#!/usr/bin/env rake
using_git = File.exist?(File.expand_path('../.git/', __FILE__))
if using_git
  require 'bundler/setup'
  require 'bundler/gem_helper'
  Bundler::GemHelper.install_tasks
  # require 'appraisal'
end
require 'rake'

Dir['./gem_tasks/*.rake'].each do |task|
  import(task)
end

require 'rspec/core/rake_task'
desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false

  t.pattern = "spec/**/_spec.rb"
  # we require spec_helper so we don't get an RSpec warning about
  # examples being defined before configuration.
  t.ruby_opts = "-I./spec -r./spec/capture_warnings -rspec_helper"
  t.rspec_opts = %w[--format progress] if (ENV['FULL_BUILD'] || !using_git)
end

require File.expand_path File.join(File.dirname(__FILE__),'lib/metric_fu')

# Borrowed from vcr
desc "Checks the spec coverage and fails if it is less than 100%"
task :check_code_coverage do
  if RUBY_VERSION.to_f < 1.9 || RUBY_ENGINE != 'ruby'
    puts "Cannot check code coverage--simplecov is not supported on this platform"
  else
    percent = Float(File.read("./coverage/coverage_percent.txt"))
    if percent < 98.0
      abort "Spec coverage was not high enough: #{percent.round(2)}%"
    else
      puts "Nice job! Spec coverage is still above 98%"
    end
  end
end

task :default => :spec
