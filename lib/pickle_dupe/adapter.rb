module Pickle
  # Abstract Factory adapter class, if you have a factory type setup, you
  # can easily create an adaptor to make it work with Pickle.
  #
  # The factory adaptor must have a #factories class method that returns 
  # its instances, and each instance must respond to:
  #
  #   #name : identifies the factory by name (default is attr_reader)
  #   #klass : returns the associated model class for this factory (default is attr_reader)
  #   #create(attrs = {}) : returns a newly created object
  class Adapter
    
    # dupe adapter
    class Dupe < Adapter
      def self.factories
        (::Dupe.models.values rescue []).map {|model| new(model)}
      end
      
      def initialize(model)
        @klass, @name = model.name.to_s.classify.constantize, model.name.to_s
      end
    
      def create(attrs = {})
        dupe_object = ::Dupe.create(@name, attrs)
        
        # getting a collection of association objects
        association_objects = attrs.select {|k,v| v.kind_of?(::Dupe::Database::Record)}.collect {|i| i[1]}
        
        association_objects.each {|association_object|
          has_one_association = dupe_object.__model__.name
          has_many_association = has_one_association.to_s.pluralize.to_sym

          # if association_model attribute_template's key matches dupe_object's pluralized name, then
          # assign, else, try with singular name
          if association_object.__model__.schema.attribute_templates.keys.include?(has_many_association)
            require 'ruby-debug'
            debugger
            # # assign has_many_association
            # has_many_values = []
            # has_many_values = association_object.send(has_many_association)
            # #FIXME: 02/11/2010 GC - This statement assigns an object to the attributes right away, how is it possible?!!
            # has_many_values << dupe_object
            # association_object.send("#{has_many_association}=",has_many_values)
            
            #trying with eval instead
            #eval("association_object.#{has_many_association}<<dupe_object")
            
            #trying with hash
            association_object[has_many_association] << dupe_object
          else #assume it's a has_one association
            association_object.send("#{has_one_association}=",dupe_object)
          end 
        }
        
        # take care of Dupe.create :ingredient, {:recipe => recipe}
        # What about Dupe.create :recipe, {:ingredients => [ingredients]} 
        # what if ingredient.recipe = recipe #=> This will need to be implemented by Dupe
        return dupe_object
        
      end
    end

  end
end