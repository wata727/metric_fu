# encoding: utf-8
source "https://rubygems.org"

if RUBY_VERSION == "1.9.2"
  # because of https://github.com/railsbp/rails_best_practices/blob/master/rails_best_practices.gemspec
  gem "activesupport", "~> 3.2"
  # because of https://github.com/troessner/reek/issues/334
  gem "reek", "~> 1.4.0"
  # rbp -> as -> i18n
  gem 'i18n', '0.6.11'
  gem "parallel", "= 1.3.3" # 1.3.4 disallows 1.9.2
else
  gem "rubocop", platforms: :mri, groups: [:test, :local_development]
end

gemspec path: File.expand_path("..", __FILE__)

platform :jruby do
  group :jruby do
    gem "jruby-openssl", "~> 0.8.5"
  end
end

group :test, :local_development  do
  gem "code_notes"

  # Debugging
  # Guard includes 'pry', so let's make that explicit
  # https://github.com/guard/guard#interactions
  # Add: edit -c, play -l number, whereami, wtf
  gem "pry",       require:  true
  # see https://github.com/pry/pry/wiki/Editor-integration
  #     https://github.com/pry/pry/wiki/Documentation-browsing
  #     https://github.com/pry/pry/wiki/Exceptions
  #     http://www.confreaks.com/videos/2864-rubyconf2013-repl-driven-development-with-pry
  # On OSX, edit ~/.editrc and add
  # bind "^R" em-inc-search-prev
  # to get 'readline' support
  #
  # Adds: 'step', 'next', 'finish', 'continue', and 'break'  commands to control execution.
  # gem "pry-byebug",   require:  false
  # see https://github.com/deivid-rodriguez/pry-byebug#execution-commands
  gem "pry-nav"
  # command completion
  gem "bond",      require:  false
  # see .pryrc for more configurations
end

# Added by devtools
group :development do
  gem "rake",  "~> 10.1.0"
  gem "yard",  "~> 0.8.7", group: :yard
end

group :guard do
  gem "guard",         "~> 1.8.1"
  gem "guard-bundler", "~> 1.0.0"
  gem "guard-rspec"

  # file system change event handling
  gem "listen",     "~> 1.3.0"
  gem "rb-fchange", "~> 0.0.6", require: false
  gem "rb-fsevent", "~> 0.9.3", require: false
  gem "rb-inotify", "~> 0.9.0", require: false

  # notification handling
  gem "libnotify",               "~> 0.8.0", require: false
  gem "rb-notifu",               "~> 0.0.4", require: false
  gem "terminal-notifier-guard", "~> 1.5.3", require: false
end
