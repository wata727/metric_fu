# encoding: utf-8
source 'https://rubygems.org'

group :test, :local_development  do
  gem 'pry'
  gem 'pry-nav'
end

gemspec :path => File.expand_path('..', __FILE__)

# Added by devtools
group :development do
  gem 'rake',  '~> 10.1.0'
  gem 'rspec', '~> 3.0.0.beta1'
  gem 'yard',  '~> 0.8.7', group: :yard
end

group :guard do
  gem 'guard',         '~> 1.8.1'
  gem 'guard-bundler', '~> 1.0.0'
  gem 'guard-rspec'

  # file system change event handling
  gem 'listen',     '~> 1.3.0'
  gem 'rb-fchange', '~> 0.0.6', require: false
  gem 'rb-fsevent', '~> 0.9.3', require: false
  gem 'rb-inotify', '~> 0.9.0', require: false

  # notification handling
  gem 'libnotify',               '~> 0.8.0', require: false
  gem 'rb-notifu',               '~> 0.0.4', require: false
  gem 'terminal-notifier-guard', '~> 1.5.3', require: false
end

platform :jruby do
  group :jruby do
    gem 'jruby-openssl', '~> 0.8.5'
  end
end
