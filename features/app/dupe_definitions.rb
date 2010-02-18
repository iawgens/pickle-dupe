# Dupe definitions
require 'dupe'

Dupe.debug = true
Dupe.sequence :recipe_title do |n|
  "Recipe #{n} Title"
end

Dupe.define :recipe do |recipe|
  recipe.title do
    Dupe.next :recipe_title
  end
  
  # has_many ingredients
  recipe.ingredients []
  
  # has_many steps
  recipe.steps []
  
  # recipe.ingredients do |ingredients|
  #     ingredients.split(', ').map do |ingredient|
  #       Dupe.find(:ingredient) do |i|
  #         i.label == labelize(ingredient)
  #       end
  #     end
  #   end
  
  recipe.after_create do |r|
    r.label = labelize(r.title)
  end
end

Dupe.define :step do |step|
  step.uniquify :title
  
  step.after_create do |s|
    s.label = labelize(s.title)
  end
end

# Not Applicable in Dupe
# Dupe.define :fancy_recipe, :class => Recipe do |t|
#   t.name {"Fancy " + Dupe.next(:reipe_title)}
# end

Dupe.define :ingredient do |ingredient|
  ingredient.uniquify :name
  
  # belongs_to_many recipes
  ingredient.recipes []
  
  ingredient.after_create do |i|
    i.label = labelize(i.name)
  end
end

def labelize(name)
  name.gsub(/\s/,'-').downcase
end