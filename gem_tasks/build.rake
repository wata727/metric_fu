# encoding: utf-8
require 'rubygems'
gemspec_path = File.expand_path('../../metric_fu.gemspec', __FILE__)
GEMSPEC = Gem::Specification.load(gemspec_path)

desc 'Build, tag, and release'
task :release => ['build','checksum','tag'] do
  name      = "#{GEMSPEC.name}-#{GEMSPEC.version}.gem"
  path      = File.join(File.expand_path('../../pkg', __FILE__), name)
  sh "gem push #{path}"
end

desc 'Builds the gem'
task :build  do
  name = "#{GEMSPEC.name}-#{GEMSPEC.version}.gem"
  path = File.join(File.expand_path('../../pkg', __FILE__), name)
end

require 'digest/sha2'

desc 'Creates a SHA512 checksum of the current version built gem'
task :checksum => ['build'] do
  checksums = File.expand_path('../../checksum', __FILE__)
  name      = "#{GEMSPEC.name}-#{GEMSPEC.version}.gem"
  path      = File.join(File.expand_path('../../pkg', __FILE__), name)

  checksum_name = File.basename(path) + '.sha512'
  checksum      = Digest::SHA512.new.hexdigest(File.read(path))

  File.open(File.join(checksums, checksum_name), 'w') do |handle|
    handle.write(checksum)
    sh "git add #{handle.path}"
  end
  sh "git commit -m 'Adding checksum for #{name}'"
end

desc 'Creates a Git tag for the current version'
task :tag do
  version = GEMSPEC.version

  sh %Q{git tag -a -m "Version #{version}" v#{version}}
end

desc 'Extracts TODO tags and the likes'
task :todo do
  regex = %w{NOTE: FIXME: TODO: THINK: @todo}.join('|')

  sh "ack '#{regex}' lib"
end
