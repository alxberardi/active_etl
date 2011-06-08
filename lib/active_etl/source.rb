module ActiveETL
  module Source
    
    # Include class methods
    def self.included(base)
      base.extend(ActiveETL::Source::ClassMethods)
      super
    end


    def id
      super
    end
      
    
    module ClassMethods
      
      def find(*args)
        super
      end
      
    end
    
  end
end
