if RUBY_VERSION <= '1.8.7'
else
  require "simplecov"
  require "simplecov-rcov"
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'apjson'
require "tempfile"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end

module Apjson
  APJSON_HOME = File.expand_path(File.dirname(__FILE__) + "/..")
  BIN_DIR = "#{APJSON_HOME}/bin"
  LIB_DIR = "#{APJSON_HOME}/lib"
  RUBY_CMD = "/usr/bin/env ruby -I #{LIB_DIR}"
  REDIRECT = {:stderr=>"2> /dev/null"}
end

Apjson.logger = Logger.new(STDERR)
if File.exist?('/tmp/Apjson.debug') then
  Apjson.logger.level = Logger::DEBUG
  Apjson::REDIRECT[:stderr] = nil
else
  Apjson.logger.level = Logger::ERROR
  Apjson::REDIRECT[:stderr] = "2> /dev/null"
end
