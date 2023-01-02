class Object
  # this is an override of an Object method that will load a class whenever it's missing
  def self.const_missing(c)
    require Rulers.to_underscore(c.to_s)
    Object.const_get(c)
  end
end
