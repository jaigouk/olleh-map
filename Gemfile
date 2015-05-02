source 'https://rubygems.org'
# ruby '2.2.2', :engine => 'jruby', :engine_version => '9.0.0.0.pre2'
# Specify your gem's dependencies in olleh-map.gemspec
gemspec

gem 'rest-client'

if ENV["JRUBY"] || RUBY_PLATFORM == "java"
  ruby '2.2.2', :engine => 'jruby', :engine_version => '9.0.0.0.pre2'
  gem 'concurrent-ruby'
else
  ruby '2.2.2'
  gem 'concurrent-ruby-ext'
end


group 'development', 'test' do
  gem 'guard'
  gem 'guard-minitest'
  gem 'pry'
  gem 'webmock'
  gem 'vcr'
  gem 'codeclimate-test-reporter', require: nil
end