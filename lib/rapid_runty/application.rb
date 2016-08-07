require "rapid_runty/routing"
require "rapid_runty/controller"

module RapidRunty
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
    # @return [status, {headers}, [response]] array
    def call(env)
      return [500, {}, []] if env["PATH_INFO"] == "/favicon.ico"
      controller_class, action = get_controller_action(env)
      controller = controller_class.new(env)
      response = controller.send(action)
      [200, { "Content-Type" => "text/html" }, [response]]
    end
  end
end
