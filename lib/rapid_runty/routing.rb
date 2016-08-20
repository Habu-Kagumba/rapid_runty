require 'rapid_runty/routes/route'

module RapidRunty
  class Application
    attr_reader :routes

    def initialize
      @routes = RapidRunty::Router::Routes.new
    end
  end
end
