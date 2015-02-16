require "spec_helper"

describe MetricFu::Templates::MetricsTemplate do

  let(:template) { Templates::MetricsTemplate.new }

  describe "#html_filename" do
    it "returns the hashed filename ending with .html" do
      expect(template.html_filename("some_file.rb")).to eq("10580a1fcbe74a931db8210462a584791545ab06.html")
    end
  end

end
