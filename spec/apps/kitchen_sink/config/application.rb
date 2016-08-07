require "rapid_runty"

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app", "controllers")

require "index_controller"

module KitchenSink
  class Application < RapidRunty::Application
  end
end
