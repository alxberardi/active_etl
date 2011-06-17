require 'active_etl/transformation'

module ActiveETL
  class DependencyKeyResolver < Transformation
    
    attr_reader :dependency_destination
    
    def initialize(dependency_destination)
      @dependency_destination = dependency_destination
    end
    
    
    def dependency_destination=(dependency_destination)
      dependency_destination_class = if dependency_destination.is_a?(Class)
        dependency_destination
      else
        dependency_destination.to_s.classify.constantize
      end
      
      raise Exception, "#{dependency_destination_class} is not a #{ActiveETL::Destination.name}" unless dependency_destination_class.is_a?(ActiveETL::Destination)
      
      @dependency_destination = dependency_destination_class
    end
    
    
    def transform(source_id)
      dependency_destination.find_by_id(source_id)
    end
    
  end
end
