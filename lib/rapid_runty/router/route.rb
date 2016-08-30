module RapidRunty
  module Router
    ##
    # Defines a single user defined route.
    class Route
      attr_accessor :verb, :path, :options, :placeholders

      def initialize(verb, path, options)
        self.verb = verb
        self.path = path
        self.options = options
        self.placeholders = {}
      end
    end
  end
end
