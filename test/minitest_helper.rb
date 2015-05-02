ENV['RACK_ENV'] = 'test'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'olleh-map'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
require 'pry'
# pull in the VCR setup
require File.expand_path './vcr_setup.rb', __dir__