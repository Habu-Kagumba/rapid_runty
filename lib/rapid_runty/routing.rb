require "rapid_runty/routes/dsl"
require "rapid_runty/routes/route"

module RapidRunty
  class Application
    include RapidRunty::Router::DSL
  end
end
