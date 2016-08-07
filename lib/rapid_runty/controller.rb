module RapidRunty
  # Application controller
  #
  # TODO: Just saves the env for now
  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
