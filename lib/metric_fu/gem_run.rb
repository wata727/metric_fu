require 'shellwords'
require 'metric_fu'
MetricFu.lib_require { 'logging/mf_debugger' }
MetricFu.lib_require { 'gem_version' }
module MetricFu
  class GemRun

    attr_reader :gem_name, :library_name, :version, :arguments
    def initialize(arguments={})
      @gem_name    = arguments.fetch(:gem_name)
      @library_name = arguments.fetch(:metric_name)
      @version = arguments.fetch(:version) { MetricFu::GemVersion.for(library_name) }
      args = arguments.fetch(:args)
      @arguments = args.respond_to?(:scan) ? Shellwords.shellwords(args) : args
    end

    def summary
      "RubyGem #{gem_name}, library #{library_name}, version #{version}, arguments #{arguments}"
    end

    def run
      execute
    rescue StandardError => run_error
      handle_run_error(run_error)
    rescue SystemExit => system_exit
      handle_system_exit(system_exit)
    ensure
      return self
    end

    def execute
      require 'rubygems'
      gem gem_name, version
      handle_argv
      load Gem.bin_path(gem_name, library_name, version)
    end

    def handle_argv
      ARGV.clear
      arguments.each do |arg|
        ARGV << arg
      end
    end

    def handle_run_error(run_error)
      STDERR.puts "ERROR: #{run_error.inspect}"
    end

    def handle_system_exit(system_exist)
      status =  system_exit.success? ? "SUCCESS" : "FAILURE"
      STDERR.puts "#{status} with code #{system_exit.status}: #{e.inspect}"
    end

  end
end
