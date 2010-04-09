# Routes
ActionController::Routing::Routes.draw do |map|
  # Since I started using recipe -> ingredient before working on path stuff, there is no turning back
  # so even if the nestedness does not make sense, I have to use it
  map.resources :recipes, :controller => 'default' do |recipe|
    recipe.resources :ingredients, :controller => 'default' do |ingredient|
      ingredient.resources :comments, :controller => 'default'
    end
  end
end