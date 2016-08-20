require 'rapid_runty/routes/matcher'

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
      # @return A RapidRunty::Router::Route Instance:
      #
      # Example:
      #   RapidRunty::Router::Routes.match("GET", "/foo/4") = #<RapidRunty::Router::Route options={"controller"=>"foo", "action"=>"bar"}, path="/foo/:id", placeholders=[], verb=:get
      def match(verb, path)
        return nil if empty?

        verb = verb.to_s.downcase.strip.to_sym

        routes = select { |route| route.verb == verb }
        paths = routes.map { |route| { url: route.path }.merge route.options }

        path, places, action = RapidRunty::Router::Matcher.match(path, paths)
        return nil if path.nil?

        route = routes.detect { |router| router.path == path }.clone
        route.placeholders = places
        route.options = action
        route
      end

      ##
      # Provides familiar DSL to defining routes
      #
      # Example:
      #   DemoApplication.routes.draw do
      #     root "demo#index"
      #     get "/demo", to: "demo#index"
      #     get "/demo/new", to: "demo#new"
      #     get "/demo/:id", to: "demo#show"
      #     get "/demo/:id/edit", to: "demo#edit"
      #     post "/demo/", to: "demo#create"
      #     put "/demo/:id", to: "demo#update"
      #     patch "/demo/:id", to: "demo#update"
      #     delete "/demo/:id", to: "demo#destroy"
      #   end
      def draw(&block)
        instance_eval(&block)
      end

      def root(controller)
        get '/', to: controller
      end

      %w(get post put patch delete).each do |method_name|
        define_method(method_name) do |path, options|
          add(method_name.to_sym, path, options)
        end
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
