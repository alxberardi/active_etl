require 'active_etl/destination_attribute'

module ActiveETL
  class Source
    
    attr_accessor :destination, :source
    
    def initialize(destination, source, destination_attributes = nil)
      @destination = destination
      @source = source.to_s
      add_destination_attributes(destination_attributes)
    end
    
    
    def find(&block)
      
    end
    
    
    def primary_key
      :id
    end
      
    
    def destination_attributes
      @destination_attributes ||= []
    end
   
      
    def define_destination_attribute(destination_attribute, source_attributes, transformations = nil)
      destination_attributes << DestinationAttribute.new(destination_attribute, self, source_attributes, transformations)
    end
    
    
    def add_destination_attribute(destination_attribute)
      raise Exception, "#{destination_attribute} is not a #{ActiveETL::DestinationAttribute.name}" unless destination_attribute.is_a?(ActiveETL::DestinationAttribute)
      raise Exception, "#{destination_attribute} is aready assigned to another source" unless destination_attribute.source.nil? || destination_attribute.source == self
      destination_attribute.source = self
      destination_attributes << destination_attribute
    end
    
    
    def add_destination_attributes(destination_attributes)
      Array.wrap(destination_attributes).each do |destination_attribute|
        add_destination_attribute(destination_attribute)
      end
    end
    
    
    def primary_key_destination_attribute
      destination_attributes.find { |a| a.source_attributes.first.to_s == primary_key.to_s } if primary_key
    end
      
  end
end
