## Contracted Interfaces

```ruby
MetricFu.run_dir #=> Dir.pwd
MetricFu.run_dir = some_path
MetricFu.run_path #=> Pathname(Dir.pwd)
MetricFu.root_dir
MetricFu.load_user_configuration
MetricFu.loader.loaded_files
MetricFu.lib_require(base = '',&block)
MetricFu.lib_dir #=> metric_fu/lib
MetricFu.metrics_require(&block)
MetricFu.metrics_dir #=> metric_fu/lib/metrics
MetricFu.formatter_require(&block)
MetricFu.formatter_dir #=> metric_fu/lib/formatter
MetricFu.reporting_require(&block)
MetricFu.reporting_dir #=> metric_fu/lib/reporting
MetricFu.logging_require(&block)
MetricFu.logging_dir   #=> metric_fu/lib/logging
MetricFu.errors_require(&block)
MetricFu.errors_dir    #=> metric_fu/lib/errors
MetricFu.data_structures_require(&block)
MetricFu.data_structures_dir #=> metric_fu/lib/data_structures
MetricFu.tasks_require(&block)
MetricFu.tasks_dir           #=> metric_fu/lib/tasks

MetricFu.configuration #=> MetricFu::Configuration.new
MetricFu.configuration.configure_metrics # for each metric, yield to block or runs enable, activate 
metric = MetricFu.configuration.configure_metric(:flog)
metric.run_options #=> metric.default_run_options.merge(metric.configured_run_options)
metric.enable
metric.enabled = true
metric.activate
metric.activated = true
metric.name #=> :flog
```

## Testing

`bundle exec rspec`

## Forking

## Issues / Pull Requests

* see [CONTRIBUTING](CONTRIBUTING.md)

## Building

`rake build` or `rake install`

## Releasing

1. Update lib/metric_fu/version.rb
2. Update HISTORY.md
3. `rake release`
