module Rulers
  # this method will be available under Rulers namespace
  # it converts CamelCase to snake_case
  # used for class lookup
  def self.to_underscore(string)
      string.
        gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
  end
end
