require 'active_etl/destination'

module ActiveETL
  module DestinationModel
  
    # Include class methods
    def self.included(base)
      base.send(:include, ActiveETL::Destination)
      base.extend(ActiveETL::DestinationModel::ClassMethods)
      super
    end
    
    
    module ClassMethods
      
      def find_by_id(id)
        self.send("find_by_#{primary_key}".to_sym, id)
      end
      
      
      protected
      
      def etl_destination_dependencies_array
        self.reflect_on_all_associations.select do |r| 
          r.macro == :belongs_to && r.klass <= ActiveETL::Destination
        end.map { |r| r.klass }
      end
      
    end
    
  end
end
