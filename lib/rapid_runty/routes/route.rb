module RapidRunty
  module Router
    ##
    # This class registers all routes defined by the draw method.
    class Routes < Array
      def add(*args)
        self << Route.new(*args)
      end

      ##
      # Match incoming paths from env to existing routes
      #
      # @param verb [String] HTTP verb extracted from Rack env
      # @param path [String] the url path extracted from Rack env
      #
      # @return []
      def match(verb, path)
        return nil if self.empty?

        verb = verb.to_s.downcase.strip.to_sym

        routes = self.select { |route| route.verb == verb }
        paths = routes.map { |route| route.path }
        options = routes.map { |route| route.options }

        path, placeholders, kontroller_action = RapidRunty::Router::Matcher.
          match(path, paths, options)
        return nil if path.nil?

        route = routes.detect { |router| router.path == path }
        route.placeholders = placeholders
        route.options = kontroller_action
        route
      end
    end

    class Route
      attr_accessor :verb, :path, :options, :placeholders

      def initialize(verb, path, options)
        self.verb = verb
        self.path = path
        self.options = options
        self.placeholders = nil
      end
    end
  end
end
