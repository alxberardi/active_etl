module ActiveETL
  module DestinationModel
  
    # Include class methods
    def self.included(base)
      base.send(:include, ActiveETL::Destination)
      base.extend(ActiveETL::DestinationModel::ClassMethods)
      super
    end
    
    
    module ClassMethods
      
      protected
      
      def etl_destination_dependencies_array
        self.reflect_on_all_associations.select do |r| 
          r.macro == :belongs_to && r.klass <= ActiveETL::Destination
        end.map { |r| r.klass }
      end
      
    end
    
  end
end
