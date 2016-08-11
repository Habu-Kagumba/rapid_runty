# Override Object.const_missing
class Object
  # Convert Constants to snake_case and try to autoload them
  def self.const_missing(c)
    require c.to_s.snake_case
    Object.const_get(c)
  end
end
