module RapidRunty
  module Router
    ##
    # Parses the route, extracts and return the various important parts of the url.
    #
    # @param [String] the request url
    class RouteParser
      attr_accessor :path, :options

      def initialize(url)
        self.path = split_url(url[:url])
        self.options = url[:to]
      rescue TypeError
        self.path = split_url(url)
      end

      def to_s
        '/' + path.join('/')
      end

      ##
      # Return the present placeholders for the url
      #
      # @return [Hash] of the placeholder key and its value.
      def placeholders
        return {} unless @match

        placeholders = {}
        path.each_with_index do |part, i|
          placeholders[part.delete(':').to_s] = @match.path[i] if part[0] == ':'
        end
        placeholders
      end

      def ==(other)
        is_match = size_match?(other) && path_match?(other)
        @match = other if is_match
        is_match
      end

      private

      def size_match?(url)
        path.size == url.path.size
      end

      def path_match?(url)
        path.each_with_index do |part, i|
          return false unless part[0] == ':' || url.path[i] == part
        end
        true
      end

      def split_url(url)
        url = url.to_s
        path_parts = url.split('/').reject(&:empty?)
        path_parts = [''] if url == '/'
        path_parts
      end
    end
  end
end
