# Extend the Ruby String class
class String
  ##
  # Returns the snake_case version of a word
  #
  # Example:
  #
  #   "IndexController".snake_case = "index_controller"
  def snake_case
    gsub!(/::/, "/")
    gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
    gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    tr!("-", "_")
    downcase!
    self
  end
end
