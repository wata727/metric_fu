require 'redcarpet'
require 'English'
require 'tmpdir'
ROOT_PATH    = File.expand_path("..", File.dirname(__FILE__))
LIB_PATH     = File.join(ROOT_PATH, 'lib')
BIN_PATH     = File.join(ROOT_PATH, 'bin')
EXAMPLE_FILES = [
  File.join(ROOT_PATH, 'README.md'),
  File.join(ROOT_PATH, 'DEV.md')
]
task "load_path" do
  $LOAD_PATH.unshift(LIB_PATH)
  $VERBOSE = nil
  ENV['PATH'] = "#{BIN_PATH}:#{ENV['PATH']}"
  ENV['CC_BUILD_ARTIFACTS'] = 'turn_off_browser_opening'
end
desc "Test that documentation usage works"
task "usage_test" => %w[load_path] do
  usage_test = UsageTest.new
  usage_test.test_files(EXAMPLE_FILES)

  puts "SUCCESS!"
  Process.exit! 0
end

class UsageTest
  def initialize
    @markdown = Redcarpet::Markdown.new(HTMLRenderAndVerifyCodeBlocks, :fenced_code_blocks => true)
  end

  def test_files(paths)
    in_test_directory do
      Array(paths).each do |path|
        puts "Testing #{path}"
        @markdown.render(File.read(path))
        puts
      end
    end
  end

  private

  def in_test_directory
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) {
        `git init; touch README; git add README; git commit -m 'first'`
        yield
      }
    end
  end
end

FenceRunner = Struct.new(:code, :language) do

  def test!
    time = Time.now
    captured_output = run_code
    mf_debug "#{Time.now - time} seconds"
    if $CHILD_STATUS.success?
      print '.'
    else
      print 'x'
      puts "Red :( language: #{language}, code #{code}, #{captured_output}"
      Process.exit! 1
    end
  end

  def run_code
    captured_output = ''
    case language
    when 'sh'
      Open3.popen3(code) do |stdin, stdout, stderr, wait_thr|
        captured_output << stdout.read.chomp
      end

    when 'ruby'
      captured_output = MfDebugger::Logger.capture_output do
        eval code
      end
    else
      nil
    end
  rescue StandardError => run_error
    p run_error
    # handle_run_error(run_error)
  rescue SystemExit => system_exit
    p system_exit
    # handle_system_exit(system_exit)
  ensure
    # print_errors
    return captured_output
  end

end
class HTMLRenderAndVerifyCodeBlocks < Redcarpet::Render::HTML

  def block_code(code, language)
    FenceRunner.new(code, language).test!
  end
# Redcarpet::Render::Base
#
# block_code(code, language)
# block_quote(quote)
# block_html(raw_html)
# footnotes(content)
# footnote_def(content, number)
# header(text, header_level, anchor)
# hrule()
# list(contents, list_type)
# list_item(text, list_type)
# paragraph(text)
# table(header, body)
# table_row(content)
# table_cell(content, alignment)
# Span-level calls
#
# A return value of nil will not output any data. If the method for a document element is not implemented, the contents of the span will be copied verbatim:
#
# autolink(link, link_type)
# codespan(code)
# double_emphasis(text)
# emphasis(text)
# image(link, title, alt_text)
# linebreak()
# link(link, title, content)
# raw_html(raw_html)
# triple_emphasis(text)
# strikethrough(text)
# superscript(text)
# underline(text)
# highlight(text)
# quote(text)
# footnote_ref(number)
# entity(text)
# normal_text(text)
# doc_header()
# doc_footer()
# preprocess(full_document)
# postprocess(full_document)

end
