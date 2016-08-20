require 'rapid_runty/routing'
require 'rapid_runty/controller'

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
    # @return [status, {headers}, [response]] array
    def call(env)
      request = Rack::Request.new(env)

      verb = request.request_method.downcase.to_sym
      path = Rack::Utils.unescape(request.path_info)

      return [500, {}, []] if path == '/favicon.ico'

      route = routes.match(verb, path)
      if route.nil?
        [404, { 'Content-Type' => 'text/html' }, '404 not found']
      else
        [200, { 'Content-Type' => 'text/html' }, ["Hello RapidRunty"]]
      end
    end
  end
end
