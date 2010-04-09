class AbstractResource < ActiveResource::Base
  self.site = ''
  def to_param
    label rescue super
  end
end

class Recipe < AbstractResource
end

class Ingredient < AbstractResource
end

class Step < AbstractResource
end