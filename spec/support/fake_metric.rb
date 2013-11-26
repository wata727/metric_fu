module MetricFu
  # SPIKE
  def fake_metric(metric_name, has_graph)
    Class.new(Metric) do
      define_method(:name) do
        metric_name
      end
      def default_run_options
        {}
      end
      define_method(:has_graph?) do
        has_graph
      end
      def enabled
        true
      end
      def activated
        true
      end
    end
  end
  def fake_generator(metric_name)
    Class.new(Generator) do
      def self.metric
        name.sub('MetricFu::','').sub('Generator','').scan(/[A-Z][a-z]+/).join('_').downcase.intern
      end
      def emit; @output = '' end
      def analyze; end
      def to_h; {self.class.metric => {}} end
    end
  end
  MetricWithoutGraph          = fake_metric(:metric_without_graph, false)
  MetricWithoutGraphGenerator = fake_generator(:metric_without_graph)
  MetricWithGraph             = fake_metric(:metric_with_graph, true)
  MetricWithGraphGenerator    = fake_generator(:metric_with_graph)
  MetricWithGraphGrapher      = Class.new(Grapher) do
    def initialize
      super
    end

    def get_metrics(metrics, date)
    end
  end
  MetricWithGraphBluffGrapher = Class.new(MetricWithGraphGrapher) do
    def title
      'metric_with_graph'
    end
    def data
      [
        ['metric_with_graph', 0]
      ]
    end
    def output_filename
      'metric_with_graph.js'
    end
  end
end
