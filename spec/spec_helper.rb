$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rapid_runty"
require "apps/kitchen_sink/config/application"
require "rspec"
require "rack/test"
require "simplecov"
require "coveralls"

ENV["RACK_ENV"] = "test"

Coveralls.wear!

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start
