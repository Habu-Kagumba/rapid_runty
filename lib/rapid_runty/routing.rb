require 'rapid_runty/routes/route'

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
    # @param [Rack::Request] req
    # @param [Rack::Response] res
    def handle(env, req, res)
      verb, path = route_args(req).values

      route = routes.match(verb, path)
      if route.nil?
        not_found(res, path)
      else
        param = "&#{Rack::Utils.build_nested_query(route.placeholder_hash)}"
        env['QUERY_STRING'] << param
        env.merge!(route.options)
        res.write dispatch(env, route, res)
      end
    end

    ##
    # Dispatch the Controller and it's action to be rendered
    def dispatch(env, route, res)
      kontroller, action = route.options.values

      controller = Object.const_get("#{kontroller.capitalize}Controller")
      controller.new(env, res).public_send(action)
    end

    ##
    # Default 404 error
    #
    # @param [Rack::Response]
    #
    # @return [Rack::Response]
    def not_found(res, path)
      res.status = 404
      res.write "
      <html>
        <head>
          <body>
            <h1>404 Page not found for #{path}</h1>
          </body>
        </head>
      </html>
      "
    end

    private

    def route_args(req)
      {
        verb: req.request_method.downcase.to_sym,
        path: Rack::Utils.unescape(req.path_info)
      }
    end
  end
end
