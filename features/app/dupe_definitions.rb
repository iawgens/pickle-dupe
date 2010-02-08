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


# Not Applicable in Dupe
# Dupe.define :fancy_recipe, :class => Recipe do |t|
#   t.name {"Fancy " + Dupe.next(:reipe_title)}
# end

Dupe.define :ingredient do |ingredient|
  ingredient.uniquify :name
  
  ingredient.after_create do |i|
    i.label = labelize(i.name)
  end
end

def labelize(name)
  name.gsub(/\s/,'-').downcase
end