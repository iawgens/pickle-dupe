module Pickle
  module Session
    # return a newly selected model when dupe is used
    def model_with_dupe(name)
      model = created_model(name)
      
      if model.kind_of?(Dupe::Database::Record)
        Dupe.find(model.__model__.name) {|dupe_model| dupe_model.id == model.id}
      else
        model_without_dupe(name)
      end
    end
    
    alias_method :model_without_dupe, :model
    alias_method :model, :model_with_dupe
  end
end