class AbstractResource < ActiveResource::Base
  self.site = ''
end
class Recipe < AbstractResource
end

class Ingredient < AbstractResource
end