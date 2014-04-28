require 'spec_helper'
require 'simplecov'
require 'metric_fu/metrics/rcov/simplecov_formatter'
require 'metric_fu/metrics/rcov/rcov'

describe SimpleCov::Formatter::MetricFu do
  before do
    @rcov_file =  subject.coverage_file_path
    File.delete( @rcov_file ) if File.exists?( @rcov_file )

    @result = SimpleCov::Result.new(
      {
       FIXTURE.fixtures_path.join('coverage.rb').expand_path.to_s =>
        [1,1,1,1,nil,1,0,1,1,nil,0,1,1]
      }
    )

    # Set to default encoding
    Encoding.default_internal = nil if defined?(Encoding)
  end

  it "test_format" do
    SimpleCov::Formatter::MetricFu.new.format( @result )

    expect(File.exists?( @rcov_file )).to be_truthy
  end

  it "test_encoding" do
    # This is done in many rails environments
    Encoding.default_internal = 'UTF-8' if defined?(Encoding)

    SimpleCov::Formatter::MetricFu.new.format( @result )
  end

  it "test_create_content" do
    content = SimpleCov::Formatter::MetricFu::FormatLikeRCov.new(@result).format
    test = "\="*80

    expect(content).to match(/#{test}/)
    expect(content).to match(/!!     value \* value/)
  end

  it 'calculates the same coverage from an RCov report as from SimpleCov' do
    next puts "can't run with simplecov" if SimpleCov.running
    SimpleCov.start # start coverage
    require 'fixtures/coverage-153'
    result = SimpleCov.result # end coverage
    source_file = result.source_files.first

    simplecov_coverage =  source_file.lines.partition{|line| line.missed? }.map(&:count)

    rcov_text = SimpleCov::Formatter::MetricFu::FormatLikeRCov.new(result).format
    analyzed_rcov_coverage = MetricFu::RCovFormatCoverage.new(rcov_text).to_h.first[1][:lines].partition{|line| !line[:was_run]}.map(&:count)

    expect(analyzed_rcov_coverage).to eq(simplecov_coverage)
  end
end
