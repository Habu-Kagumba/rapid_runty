require 'rapid_runty/router/routes'

module RapidRunty
  class Application
    attr_reader :routes

    def initialize
      @routes = RapidRunty::Router::Routes.new
    end

    # Core response method. Process the request and return the correct
    # response or status message.
    #
    # @param env
    # @param [Rack::Request] request
    # @param [Rack::Response] response
    def handle(env, request)
      verb, path = route_args(request).values

      route = routes.find_route(verb, path)
      if route.nil?
        not_found(path)
      else
        param = "&#{Rack::Utils.build_nested_query(route.placeholders)}"
        env['QUERY_STRING'] << param
        env.merge!(route.options)
        dispatch(env, route, request)
      end
    end

    ##
    # Dispatch the Controller and it's action to be rendered
    def dispatch(env, route, request)
      kontroller, action = route.options.values

      controller = Object.const_get("#{kontroller.camel_case}Controller")
      controller.new(env, request).call_action(action)
    end

    ##
    # Default 404 error
    #
    # @param [Rack::Response]
    #
    # @return [Rack::Response]
    def not_found(path)
      [
        404,
        {},
        [
          "
          <html>
            <head>
              <body>
                <h1>404 Page not found for #{path}</h1>
              </body>
            </head>
          </html>
          "
        ]
      ]

    end

    private

    def route_args(request)
      {
        verb: request.request_method.downcase.to_sym,
        path: Rack::Utils.unescape(request.path_info)
      }
    end
  end
end
