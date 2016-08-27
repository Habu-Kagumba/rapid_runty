require 'rapid_runty/router/base_route'
require 'rapid_runty/controller/base_controller'
require 'rapid_runty/model/base'

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
      handle(env, request)
    end
  end
end
