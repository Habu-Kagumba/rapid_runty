require "rapid_runty"
$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app")

module KitchenSink
  class Application < RapidRunty::Application
  end
end
