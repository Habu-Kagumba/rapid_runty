# Extend the Ruby String class
class String
  ##
  # Returns the snake_case version of a word
  #
  # Example:
  #
  #   "IndexController".snake_case = "index_controller"
  def snake_case
    gsub!(/::/, '/')
    gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
    gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    tr!('-', '_')
    downcase!
    self
  end

  ##
  # Returns the CamelCase version of a word
  #
  # Example:
  #   "index_controller".camel_case = "IndexController"
  def camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split('_').map(&:capitalize).join
  end
end
