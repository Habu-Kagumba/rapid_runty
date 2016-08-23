module RapidRunty
  ##
  # Application base controller
  class BaseController
    attr_reader :env, :response

    def initialize(env, response)
      @env = env
      @response = response
    end

    ##
    # Fetch request params
    #
    # @return [Hash] Hash of url parameters
    def params
      @params ||= Rack::Utils.parse_nested_query(env['QUERY_STRING'])
    end

    ##
    # Render the template with a default layout.
    #
    # @param [String] file name for the template
    def render(view = controller_action)
      render_template(layout) do
        render_template(view)
      end
    end

    ##
    # Tilt method to render specific template
    #
    # @return Rack::Response compatible response [body, status, header]
    def render_template(path, &block)
      Tilt.new(file(path)).render(self, &block)
    end

    ##
    # Find template file
    #
    # @return [Path] template path
    def file(path)
      Dir[File.join(ROOT_DIR, 'app', 'views', "#{path}.html.*")].first
    end

    ##
    # Define Layout template location
    #
    # @return [Path] the layout template location
    def layout
      File.join('layouts', 'application')
    end

    ##
    # Redirect response method
    def redirect_to(path)
      response.redirect path
    end

    private

    def controller_action
      File.join(env['controller'], env['action'])
    end
  end
end
