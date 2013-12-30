def enable_hotspots
  MetricFu.configure
  hotspot_metrics = MetricFu::Metric.metrics.map(&:name)
  hotspot_metrics.each do |metric_name|
    path = "#{metric_name}/#{metric_name}_hotspot"
    begin
      MetricFu.metrics_require { path }
    rescue LoadError
      # No hotspot, but that's ok
    end
  end
end

def metric_not_activated?(metric_name)
  MetricFu.configuration.configure_metrics
  if MetricFu::Metric.get_metric(metric_name.intern).activate
    false
  else
    p "Skipping #{metric_name} tests, not activated"
    true
  end
end

def breaks_when?(bool)
  p "Skipping tests in #{caller[0]}. They unnecessarily break the build." if bool
  bool
end

def compare_paths(path1, path2)
  expect(File.join(MetricFu.root_dir, path1)).to eq(File.join(MetricFu.root_dir, path2))
end
