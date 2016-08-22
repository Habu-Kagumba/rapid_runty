require 'pathname'

module RapidRunty
  module Router
    ##
    # Matches passed in path with array of application paths
    module Matcher
      def self.match(*args)
        Base.match(*args)
      end

      class Base
        ##
        # Defines the route that matches the path
        #
        # Example:
        #
        #   RapidRunty::Router::Matcher.match("/foo", [{url: "/", to: "root#index"}, {url: "/bar", to: "bar#index"}, {url: "/foo", to: "foo#index"}]) #=> ["/foo", [], { controller: "foo", action: "index" }]
        #   RapidRunty::Router::Matcher.match("/04/01/01", [{url: "/:day/:month/:year", to: "date#find"}]) #=> ["/", ["04", "01", "01"], { controller: "date", action: "find" }]
        # @param path [String] path from ENV["PATH_INFO"]
        # @param application routes [Array] Array of Hash application defined routes
        #
        # Currently only supporting ":to" options which defines the "controller#action"
        #
        # @return [matching_route, matched_placeholders, matched_controller_action] array
        #
        def self.match(path, routes)
          path = Path.new(path)
          url_patterns = routes.map { |route| URLPattern.new(route) }

          url_patterns.each do |pattern|
            return [
              pattern.to_s, pattern.placeholders,
              ControllerSetup.controller_action(pattern.options),
              pattern.placeholder_hash
            ] if pattern == path
          end

          [nil, [], {}, []]
        end
      end

      class Path
        attr_accessor :parts, :ext, :options

        def initialize(path)
          path = Pathname(path)
          self.parts, self.ext = split_path(path)
        rescue TypeError
          self.parts, self.ext = split_path(path[:url])
          self.options = path[:to]
        end

        def to_s
          '/' + parts.join('/') + ext
        end

        private

        def split_path(path)
          path = path.to_s
          ext = Pathname(path).extname
          path = path.sub(/#{ext}$/, '')
          parts = path.split('/').reject(&:empty?)
          parts = [''] if path == '/'
          [parts, ext]
        end
      end

      class URLPattern < Path
        def placeholders
          return [] unless @match

          vars = []
          parts.each_with_index do |part, i|
            vars << @match.parts[i] if part[0] == ':'
          end
          vars
        end

        def placeholder_hash
          if instance_variable_defined?(:@match) && !placeholders.empty?
            url_parts = instance_variable_get(:@match)
            pattern_var = parts.select { |part| part[0] == ':' }.first
            var_index = parts.index(pattern_var)
            return {
              pattern_var.delete(':').to_s => url_parts.parts[var_index]
            }
          end
          []
        end

        def ==(other)
          is_match = size_match?(other) && parts_match?(other)
          @match = other if is_match
          is_match
        end

        private

        def size_match?(path)
          parts.size == path.parts.size
        end

        def parts_match?(path)
          parts.each_with_index do |part, i|
            return false unless part[0] == ':' || path.parts[i] == part
          end
          true
        end
      end

      class ControllerSetup
        def self.controller_action(options)
          Hash[
            %w(controller action).zip options.split('#')
          ]
        end
      end
    end
  end
end
