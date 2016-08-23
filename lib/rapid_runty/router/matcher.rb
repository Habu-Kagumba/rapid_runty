require 'rapid_runty/router/route_parser'

module RapidRunty
  module Router
    ##
    # Matches passed in path with array of application paths
    class Matcher
      ##
      # Defines the route that matches the path
      #
      # Example:
      #
      #   RapidRunty::Router::Matcher.new.match("/foo", [{url: "/", to: "root#index"}, {url: "/bar", to: "bar#index"}, {url: "/foo", to: "foo#index"}]) #=> ["/foo", [], { controller: "foo", action: "index" }]
      #   RapidRunty::Router::Matcher.new.match("/04/01/01", [{url: "/:day/:month/:year", to: "date#find"}]) #=> ["/", ["04", "01", "01"], { controller: "date", action: "find" }]
      # @param path [String] path from ENV["PATH_INFO"]
      # @param application routes [Array] Array of Hash application defined routes
      #
      # Currently only supporting ":to" options which defines the "controller#action"
      #
      # @return [matching_route, matched_placeholders, matched_controller_action] array
      #
      def match(path, routes)
        path = route_parser.new(path)
        url_patterns = routes.map { |route| route_parser.new(route) }

        url_patterns.each do |pattern|
          return [
            pattern.to_s,
            pattern.placeholders,
            controller_action(pattern.options)
          ] if pattern == path
        end

        [nil, {}, {}]
      end

      def controller_action(options)
        Hash[
          %w(controller action).zip options.split('#')
        ]
      end

      private

      def route_parser
        RapidRunty::Router::RouteParser
      end
    end
  end
end
