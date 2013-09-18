require 'fileutils'
require 'coderay'
MetricFu.metrics_require { 'base_template' }
MetricFu.lib_require { 'utility' }

class AwesomeTemplate < MetricFu::Template

  def write
    @name = Pathname.new(MetricFu.root_dir).basename
    copy_javascripts
    @metrics = {}
    result.each_pair do |section, contents|
      write_metric_page_for_section(@metrics, section, contents)
    end
    write_index_page
    write_file_data
  end
  
  private
  
  def copy_javascripts
    # Copy Bluff javascripts to output directory
    Dir[File.join(template_directory, '..', 'javascripts', '*')].each do |f|
      FileUtils.cp(f, File.join(self.output_directory, File.basename(f)))
    end
  end
  
  def write_metric_page_for_section(metrics, section, contents)
    if not template_exists?(section)
      mf_debug  "no template for section #{section} with #{template(section)} for result #{result.class}"
      return
    end
    create_instance_var(section, contents)
    metrics[section] = contents
    create_instance_var(:per_file_data, per_file_data)
    mf_debug  "Generating html for section #{section} with #{template(section)} for result #{result.class}"
    @html = erbify(section)
    html = erbify('layout')
    fn = output_filename(section)
    formatter.write_template(html, fn)
  end

  def write_index_page
    if not template_exists?('index')
      mf_debug  "no template for section index for result #{result.class}"
    end
    @html = erbify('index')
    html = erbify('layout')
    fn = output_filename('index')
    formatter.write_template(html, fn)
  end

  module HtmlFormatter
  
    module_function
    # CodeRay options
    # used to analyze source code, because object Tokens is a list of tokens with specified types.
    # :tab_width – tabulation width in spaces. Default: 8
    # :css – how to include the styles (:class и :style). Default: :class)
    #
    # :wrap – wrap result in html tag :page, :div, :span or not to wrap (nil)
    #
    # :line_numbers – how render line numbers (:table, :inline, :list or nil)
    #
    # :line_number_start – first line number
    #
    # :bold_every – make every n-th line number bold. Default: 10
    def to_html(ruby_text, line_number)
      tokens = CodeRay.scan(MetricFu::Utility.clean_ascii_text(ruby_text), :ruby)
      options = { :css => :class, :style => :alpha }
      if line_number.to_i > 0
        options = options.merge({:line_numbers => :inline, :line_number_start => line_number.to_i })
      end
      tokens.div(options)
    end
    
  end
  
  def write_file_data
    per_file_data.each_pair do |file, lines|
      write_per_file_data(file, lines)
    end
  end
  def read_filelines(file)
    File.open(file, 'r') { |f| f.readlines }
  end
  def filename(file)
    "#{file.gsub(%r{/}, '_')}.html"
  end
  def html_header
    <<-HTML
      <html><head><style>
        #{inline_css('css/syntax.css')}
        #{inline_css('css/bluff.css') if MetricFu.configuration.graph_engine == :bluff}
        #{inline_css('css/rcov.css') if @metrics.has_key?(:rcov)}
      </style></head><body>
    HTML
  end
  def write_per_file_data(file, lines)
    data = read_filelines(file)
    out = build_page(file,lines)
    formatter.write_template(out, filename(file))
  end
  def build_page(file, lines)
    out = html_header
    out << "<table cellpadding='0' cellspacing='0' class='ruby'>"
    data.each_with_index do |line, idx|
      out << html_row(lines, line, idx)
    end
    out << "<table></body></html>"
  end
  def html_row(lines, line, idx)
    line_number = (idx + 1).to_s
    out << "<tr>"
    out << description_cell(lines, line_number)
    out << code_cell(line, line_number)
    out << "</tr>"
  end
  
  def description_cell(lines, line_number)
    out = ''
    out << "<td valign='top'>"
    if lines.has_key?(line_number)
      out << "<ul>"
       lines[line_number].each do |problem|
        out << "<li>#{problem[:description]} &raquo; #{problem[:type]}</li>"
      end
      out << "</ul>"
    else
      out << "&nbsp;"
    end
    out << "</td>"
  end
  
  def code_cell(line, line_number)
    "<td valign='top'>#{line_for_display(line, line_number)}</td>"
  end
  
  def line_for_display(line, line_number)
    if MetricFu::Formatter::Templates.option('syntax_highlighting')
      HtmlFormater.to_html(line, line_number)
    else
      "<a name='n#{line_number}' href='n#{line_number}'>#{line_number}</a>#{line}"
    end
  end
  
  def template_directory
    File.dirname(__FILE__)
  end
end
