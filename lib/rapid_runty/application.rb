require 'rapid_runty/router/base_route'
require 'rapid_runty/controller/base_controller'

module RapidRunty
  ##
  # Main framework Application class. Entry point for all requests.
  #
  # Example:
  #
  #   class Application < RapidRunty::Application
  #   end
  class Application
    ##
    # Returns a rack compatible response.
    #
    # Retrieves the controller and action from request URL making a new
    # controller and send it to the action.
    #
    # @param env [Hash] Rack environment Hash that includes CGI-like headers
    #
    # @return [status, {headers}, [response]]
    def call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new

      handle(env, request, response)
      response.finish
    end
  end
end
