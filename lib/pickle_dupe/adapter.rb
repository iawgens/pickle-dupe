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
        # Not all dupe models has an associated model class
        # so we dynamically create them here
        unless @klass = (model.name.to_s.classify.constantize rescue nil)
          class_handler = Object.const_set(model.name.to_s.classify, Class.new(ActiveResource::Base))
          class_handler.site = 'http://test.com'
          puts "WARNING: #{model.name} model is defined dynamically because there was a dupe definition but no model was defined"
        end
        @name = model.name.to_s
      end

      def create(attrs = {})
        duped_object = ::Dupe.create(@name, attrs)
        assign_missing_associations(duped_object, attrs) unless attrs.blank?

        return @klass.send(:find, duped_object.id)
      end
      
    private
    
      # Since ActiveResource does not have the notion of relationship between models, when associating
      # a duped object to another object, Dupe does not take care of the association in both ways.
      #
      # Consider the following example with Recipe and DirectionStep. A recipe has many direction_steps 
      # and a direction_step belongs to one recipe. To setup dupe data for the cucumber scenario, we do the following:
      #
      #   @recipe = Dupe.create :recipe #=> <#Duped::Recipe id=1>
      #   @direction_step = Dupe.create(:direction_step, {:recipe => @recipe}) 
      #     #=> <#Duped:DirectionStep recipe=<#Duped::Recipe id=1> id=1>
      #
      # That would associate the duped recipe to the duped ingredient. However, the duped recipe has
      # no knowledge of the direction_step.
      #
      #   @recipe.direction_steps #=> nil
      #
      # Since Dupe does not handle the reverse association, this method thus assign the association to the 
      # has_many side when a duped object is assigned to the belongs_to side when using pickle steps.
      #
      # To implement this association, you must let Dupe knows that a has_many association is expected by defining
      # it in dupe definition as follows:
      #
      #   Dupe.define :recipe do |recipe|
      #     recipe.direction_steps []
      #   end
      #
      # Once defined, when you call a pickle step to assign a belongs_to association, like:
      #
      #   Given a recipe: "one" exists
      #   And a direction step exists with recipe: recipe "one"
      # 
      # Then the "Then" step would be able to get the direction steps through the recipe duped object, like: 
      #
      #   Then the first direction step should be in recipe "one"'s direction steps
      #
      # This hack took care of has side when assigning to belongs_to side when it's a many_to_one:
      #   
      #   Dupe.create :direction_step, {:recipe => recipe}
      #
      # but does not take care of the many_to_many relationship like:
      #
      #   Dupe.create :recipe, {:ingredients => [<Duped::Ingredient>,<Duped::Ingredient>]}
      #
      def assign_missing_associations(duped_object, attrs)
        association_objects = collect_association_objects(attrs)
        association_objects.each {|association_object|
          # When a pickle step causes Dupe to do the following:
          # 
          #  Dupe.create(:direction_step, :recipe => @recipe)
          #
          # Then duped_object would be of class Dupe::DirectionStep and association_object would be of
          # class Dupe::Recipe.
          assign_association(association_object, duped_object)
        }
      end
      
      def assign_association(association_object, duped_object)
        has_one_association = duped_object.__model__.name #=> :direction_step
        has_many_association = has_one_association.to_s.pluralize.to_sym #=> :direction_steps
        
        # The following would check for the existence of the key :direction_steps
        # in the duped recipe's definition
        association_duped_object = ::Dupe.find(association_object.class.name.underscore){|d| 
            d.id == association_object.id
          }
        if association_duped_object.__model__.schema.attribute_templates.keys.include?(has_many_association)
          association_duped_object[has_many_association] << duped_object
        else #assume it's a has_one association
          association_duped_object[has_one_association] = duped_object
        end
      end
      
      # Selecting association objects from the attributes hash and return as array. Association objects are of class
      # Dupe::Database::Record
      # Given :association => <#Duped::Ingredient name="ingredient 1 name" recipes=[] label="ingredient-1-name" id=1> or
      # :association => [<#Duped...>] will return [[<#Duped...>,<#Duped...>],<#Duped...>]
      def collect_association_objects(attrs)
        attrs.select {|k,v| 
          v.kind_of?(Array) || v.kind_of?(ActiveResource::Base)
        }.collect {|i| i[1]}.flatten
      end
      
    end

  end
end