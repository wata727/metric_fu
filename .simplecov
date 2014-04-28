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

  add_group "Metrics", "lib/metric_fu/metrics"
  add_group "Hotspots", "lib/metric_fu/metrics/hotspots"
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
end
