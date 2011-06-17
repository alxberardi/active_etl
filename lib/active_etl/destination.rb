require 'active_record'
require 'active_etl/source'

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
        subclass.etl_source_attribute = self.etl_source_attribute
        subclass.etl_sources_array = self.etl_sources
        subclass.etl_destination_dependencies_array= self.etl_destination_dependencies
      end
      
      
      def etl_source_attribute
        @source_attribute
      end
      
      
      def etl_source_attribute=(source_attribute)
        @source_attribute = source_attribute
      end
      
      
      def add_etl_source(source)
        raise Exception, "#{source} is not a #{ActiveETL::Source.name}" unless source.is_a?(ActiveETL::Source)
        etl_sources_array << source 
      end
      
      
      def etl_sources
        etl_sources_array.clone
      end
      
      
      def etl_destination_dependencies
        etl_destination_dependencies_array.clone
      end
      
      
      def set_etl_destination_dependencies(dependencies)
        self.etl_destination_dependencies_array=(dependencies)
      end
      
      
      def run_etl
        execute_etl
      end
      
      
      protected
      
      def etl_sources_array
        @etl_sources ||= []
      end
      
      
      def etl_sources_array=(sources)
        @etl_sources = sources
      end
      
      
      def etl_destination_dependencies_array
        @etl_destination_dependencies ||= []
      end
      
      
      def etl_destination_dependencies_array=(dependencies)
        @etl_destination_dependencies = dependencies
      end
      
      
      def find_by_source_conditions(source)
        conditions = {}
        
        if etl_source_attribute
          source_class = if source.is_a?(Class)
            source
          else
            source.to_s.class
          end

          raise Exception, "#{source_class} is not a #{ActiveETL::Source.name}" unless source_class.is_a?(ActiveETL::Source)
          
          conditions[etl_source_attribute.to_sym] = source.source
        end
        
        conditions
      end
      
      
      def execute_etl
        # TODO : Delete destination rows corresponding to deleted source rows
        
        etl_sources_array.each do |source|
          source.find do |source_rows|
            source_rows.each do |source_row|
              # Update destination rows corresponding to existing source rows
              destination_row = if primary_key_attribute = source.primary_key_destination_attribute
                conditions = find_by_source_conditions(source)
                conditions[primary_key_attribute.destination_attribute.to_sym] = source_row.send(source.primary_key)
                self.find(:first, :conditions => conditions)
              end
              # Create destination rows corresponding to new source rows
              destination_row ||= self.new
              source.destination_attributes.each do |destination_attribute|
                destination_row.send(destination_attribute.destination_attribute, destination_attribute.value(source_row))
              end
              destination_row.save!
            end
          end
        end
      end
      
    end
    
  end
end
