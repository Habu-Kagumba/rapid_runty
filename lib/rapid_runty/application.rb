module RapidRunty
  # Main framework Application class. Entry point for all requests.
  class Application
    ##
    # Returns a rack compatible response.
    #
    # @return [status, {headers}, [response]] array
    def call(env)
      @req = Rack::Request.new(env)
      path = @req.path_info
      return [500, {}, []] if path == "/favicon.ico"
      [200, { "Content-Type" => "text/html" }, ["Hello"]]
    end
  end
end
