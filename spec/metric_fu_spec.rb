# coding: utf-8
require 'spec_helper'

describe MetricFu do

  specify "the default report_name is the run directory base name" do
    expect(MetricFu.report_name).to eq('dummy')
  end

  specify "the user can set the report_name" do
    original_report_name = MetricFu.report_name

    MetricFu.report_name = 'override'
    expect(MetricFu.report_name).to eq('override')

    MetricFu.report_name = original_report_name
  end

end
