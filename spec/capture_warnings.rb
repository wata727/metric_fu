# https://raw.githubusercontent.com/metric_fu/metric_fu/master/spec/capture_warnings.rb
require 'rubygems' if RUBY_VERSION =~ /^1\.8/
require 'bundler/setup'
require 'rspec/core'
require 'rspec/expectations'
require 'tempfile'

stderr_file = Tempfile.new("metric_fu.stderr")
current_dir = Dir.pwd

RSpec.configure do |config|

  config.before(:suite) do
    $stderr.reopen(stderr_file.path)
    $VERBOSE = true
  end

  config.after(:suite) do
    stderr_file.rewind
    lines = stderr_file.read.split("\n").uniq
    stderr_file.close!

    $stderr.reopen(STDERR)

    metric_fu_warnings, other_warnings = lines.partition { |line| line.include?(current_dir) }

    if metric_fu_warnings.any?
      puts
      puts "-" * 30 + " metric_fu warnings: " + "-" * 30
      puts
      puts metric_fu_warnings.join("\n")
      puts
      puts "-" * 75
      puts
    end

    if other_warnings.any?
      File.open('tmp/warnings.txt', 'w') { |f| f.write(other_warnings.join("\n")) }
      puts
      puts "Non-metric_fu warnings written to tmp/warnings.txt"
      puts
    end

    # fail the build...
    raise "Failing build due to metric_fu warnings" if metric_fu_warnings.any?
  end

end
