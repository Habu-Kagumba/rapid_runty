module RapidRunty
  # Application controller
  #
  # TODO: Just saves the env for now
  class Controller
    def initialize(env)
      @env = env
    end

    attr_reader :env
  end
end
