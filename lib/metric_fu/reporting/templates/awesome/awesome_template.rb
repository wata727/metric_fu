require 'fileutils'
MetricFu.metrics_require { 'base_template' }
MetricFu.lib_require { 'formatter/syntax' }

class AwesomeTemplate < MetricFu::Template

  def write
    # Getting rid of the crap before and after the project name from integrity
    # @name = File.basename(MetricFu.run_dir).gsub(/^\w+-|-\w+$/, "")
    @name = Pathname.new(MetricFu.run_dir).basename

    # Copy Bluff javascripts to output directory
    Dir[File.join(template_directory, '..', 'javascripts', '*')].each do |f|
      FileUtils.cp(f, File.join(self.output_directory, File.basename(f)))
    end

    @metrics = {}
    result.each_pair do |section, contents|
      if template_exists?(section)
        create_instance_var(section, contents)
        @metrics[section] = contents
        create_instance_var(:per_file_data, per_file_data)
        mf_debug  "Generating html for section #{section} with #{template(section)} for result #{result.class}"
        @html = erbify(section)
        html = erbify('layout')
        fn = output_filename(section)
        formatter.write_template(html, fn)
      else
        mf_debug  "no template for section #{section} with #{template(section)} for result #{result.class}"
      end
    end

    # Instance variables we need should already be created from above
    if template_exists?('index')
      @html = erbify('index')
      html = erbify('layout')
      fn = output_filename('index')
      formatter.write_template(html, fn)
    else
      mf_debug  "no template for section index for result #{result.class}"
    end

    write_file_data
  end

  def convert_ruby_to_html(ruby_text, line_number)
    MetricFu::Formatter::Syntax.new.highlight(ruby_text, line_number)
  end

  def write_file_data

    per_file_data.each_pair do |file, lines|
      next if file.to_s.empty?
      next unless File.file?(file)

      data = File.readlines(file)
      fn = "#{file.gsub(%r{/}, '_')}.html"

      out = <<-HTML
        <html><head><style>
          #{inline_css('css/syntax.css')}
          #{inline_css('css/bluff.css') if MetricFu.configuration.graph_engine == :bluff}
          #{inline_css('css/rcov.css') if @metrics.has_key?(:rcov)}
        </style></head><body>
      HTML
      out << "<table cellpadding='0' cellspacing='0' class='ruby'>"
      data.each_with_index do |line, idx|
        line_number = (idx + 1).to_s
        out << "<tr>"
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
        if MetricFu::Formatter::Templates.option('syntax_highlighting')
          line_for_display = convert_ruby_to_html(line, line_number)
        else
          line_for_display = "<a name='n#{line_number}' href='n#{line_number}'>#{line_number}</a>#{line}"
        end
        out << "<td valign='top'>#{line_for_display}</td>"
        out << "</tr>"
      end
      out << "<table></body></html>"

      formatter.write_template(out, fn)
    end
  end
  def template_directory
    File.dirname(__FILE__)
  end
end

