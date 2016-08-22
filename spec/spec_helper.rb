require 'simplecov'
require 'coveralls'

Coveralls.wear!

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

# Always use local version of RapidRunty
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../spec', __FILE__)

ROOT_DIR = File.join(__dir__, 'support', 'todoList')

require 'rapid_runty'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'
require 'support/todoList/config/application'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

Capybara.app = Rack::Builder.
  parse_file("#{__dir__}/support/todoList/config.ru").first

ENV['RACK_ENV'] = 'test'
