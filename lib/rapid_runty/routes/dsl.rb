module RapidRunty
  module Router

    ##
    # Provides familiar DSL to defining routes
    #
    # Example:
    #   DemoApplication.routes.draw do
    #     get "/demo", to: "demo#index"
    #     get "/demo/new", to: "demo#new"
    #     get "/demo/:id", to: "demo#show"
    #     get "/demo/:id/edit", to: "demo#edit"
    #     post "/demo/", to: "demo#create"
    #     put "/demo/:id", to: "demo#update"
    #     patch "/demo/:id", to: "demo#update"
    #     delete "/demo/:id", to: "demo#destroy"
    #   end
    module DSL
      attr_reader :routes

      def self.included(base)
        base.class_eval do
          @routes = RapidRunty::Router::Routes.new
        end
      end

      def draw(&block)
        instance_eval(&block)
      end

      %w(get post put patch delete).each do |method_name|
        define_method(method_name) do |path, options|
          routes.add(method_name.to_sym, path, options)
        end
      end
    end
  end
end
