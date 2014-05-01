# https://github.com/colszowka/simplecov#using-simplecov-for-centralized-config
# see https://github.com/colszowka/simplecov/blob/master/lib/simplecov/defaults.rb
if SimpleCov.respond_to?(:profiles)
  SimpleCov.profiles
else
  SimpleCov.adapters
end.define 'metric_fu' do
  if defined?(load_profile)
    load_profile  'test_frameworks'
  else
    load_adapter 'test_frameworks'
  end

  add_group "Cli",             "lib/metric_fu/cli"
  add_group "Data Structures", "lib/metric_fu/data_structures"
  add_group "Formatters",      "lib/metric_fu/formatter"
  add_group "Hotspots",        "lib/metric_fu/metrics/hotspots"
  add_group "Metrics",         "lib/metric_fu/metrics"
  add_group "Reporters",       "lib/metric_fu/reporting"
  add_group "Templates",       "lib/metric_fu/templates"

  add_group "Long files" do |src_file|
    src_file.lines.count > 100
  end
  class MaxLinesFilter < SimpleCov::Filter
    def matches?(source_file)
      source_file.lines.count < filter_argument
    end
  end
  add_group "Short files", MaxLinesFilter.new(5)

  # Exclude these paths from analysis
  add_filter 'bundle'
  add_filter 'bin'
  add_filter 'lib/metric_fu/tasks'
end
SimpleCov.at_exit do
  File.open(File.join(SimpleCov.coverage_path, 'coverage_percent.txt'), 'w') do |f|
    f.write SimpleCov.result.covered_percent
  end
  SimpleCov.result.format!
end
