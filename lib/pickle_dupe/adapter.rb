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
        ::Dupe.create(@name, attrs)
      end
    end

  end
end