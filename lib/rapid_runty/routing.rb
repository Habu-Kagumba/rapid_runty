module RapidRunty
  class Application
    # Retrieve the controller and action method from the URL
    #
    # @param env [Hash] Rack environment Hash that includes CGI-like headers
    #
    # @return [Controller, Action] array
    def get_controller_action(env)
      _, controller, action, _other = env["PATH_INFO"].split("/", 4)
      controller = controller.capitalize
      controller += "Controller"

      # Lookup controller constant name and return [controller, action]
      [Object.const_get(controller), action]
    end
  end
end
