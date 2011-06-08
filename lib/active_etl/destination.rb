module ActiveETL
  module Destination
    
    # Include class methods
    def self.included(base)
      base.extend(ActiveETL::Destination::ClassMethods)
      super
    end
      
    
    module ClassMethods
      
      def inherited(subclass)
        super
        subclass.set_etl_main_source(self.etl_main_source)
        subclass.etl_attributes_sources_hash = self.etl_attributes_sources
        subclass.etl_destination_dependencies_array= self.etl_destination_dependencies
      end
      
      
      def etl_main_source
        @etl_main_source
      end
      
      
      def set_etl_main_source(source)
        @etl_main_source = source
      end
      
      
      def define_etl_attribute_source(attribute, options)
        options ||= {}
        etl_attributes_sources_hash[attribute.to_s.to_sym] = AttributeSource.new(attribute, options[:source], options[:source_attributes], options[:transformations])
      end
      
      
      def etl_attributes_sources
        etl_attributes_sources_hash_clone
      end
      
      
      def etl_destination_dependencies
        etl_destination_dependencies_array.clone
      end
      
      
      def set_etl_destination_dependencies(dependencies)
        self.etl_destination_dependencies_array=(dependencies)
      end
      
      
      
      protected
      
      def etl_attributes_sources_hash
        @etl_attributes_sources ||= {}
      end
      
      
      def etl_attributes_sources_hash=(hash)
        @etl_attributes_sources = hash
      end
      
      
      def etl_attribute_source(attribute)
        etl_attributes_sources_hash[attribute.to_s.to_sym]
      end
      
      
      def etl_attributes_sources_hash_clone
        clone = {}
        etl_attributes_sources_hash.each do |k,v|
          clone[k] = v.clone
        end
        clone
      end
      
      
      def etl_destination_dependencies_array
        @etl_destination_dependencies ||= []
      end
      
      
      def etl_destination_dependencies_array=(dependencies)
        @etl_destination_dependencies = dependencies
      end
      
    end
    
  end
end
