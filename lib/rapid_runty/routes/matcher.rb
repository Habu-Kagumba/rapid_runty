require "pathname"

module RapidRunty
  module Router
    module Matcher #:nodoc:
      def self.match(*args)
        Base.match(*args)
      end

      # rubocop:disable Metrics/LineLength
      class Base
        ##
        # Defines the route that matches the path
        #
        # @param path [String] path from ENV["PATH_INFO"]
        # @param routes [Array] application defined routes
        # @param options [Array] extra Hash options for the route
        #
        # Currently only supporting ":to" options which defines the "controller#action"
        #
        # @return [matching_route, matched_placeholders] array
        #
        # Example:
        #
        #   RapidRunty::Router::Matcher.match("/foo", ["/", "/bar", "/foo"], [{ to: "foo#index" }]) #=> ["/foo", [], { controller: "Foo", action: "index" }]
        #   RapidRunty::Router::Matcher.match("/04/01/01", ["/:day/:month/:year"], [{}]) #=> ["/", ["04", "01", "01"], nil]

        def self.match(path, routes, options)
          require'pry';binding.pry
          path = Path.new(path)
          url_patterns = routes.map do |route|
            URLPattern.new(Array(route).first)
          end
          kontrollers = ControllerSetup.controller_action(options).first

          url_patterns.each do |pattern|
            return [
              pattern.to_s,
              pattern.placeholders,
              kontrollers
            ] if pattern == path
          end

          [nil, [], {}]
        end
      end
      # rubocop:enable Metrics/LineLength

      class Path #:nodoc:
        attr_accessor :parts, :ext

        def initialize(path)
          self.parts, self.ext = split_path(path)
        end

        def to_s
          "/" + self.parts.join("/") + self.ext
        end

        private

        def split_path(path)
          path = path.to_s
          ext = Pathname(path).extname
          path = path.sub(/#{ext}$/, "")
          parts = path.split("/").reject { |part| part.empty? }
          [parts, ext]
        end
      end

      class URLPattern < Path #:nodoc:

        def placeholders
          return [] unless @match

          vars = []
          self.parts.each_with_index do |part,i|
            vars << @match.parts[i] if part[0] == ?:
          end
          vars
        end

        def ==(path)
          is_match = size_match?(path) && parts_match?(path)
          @match = path if is_match
          is_match
        end

        private

        def size_match?(path)
          self.parts.size == path.parts.size
        end

        def parts_match?(path)
          self.parts.each_with_index do |part, i|
            return true if part[0] == ?: || path.parts[i] == part
          end
          false
        end
      end

      class ControllerSetup #:nodoc:
        attr_accessor :controller_action

        def self.controller_action(options)
          options.map do |opt|
            Hash[
              %w(controller action).zip opt[:to].split("#")
            ]
          end
        end
      end
    end
  end
end
