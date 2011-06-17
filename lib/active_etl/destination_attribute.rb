require 'active_etl/transformation'

module ActiveETL
  class DestinationAttribute

    attr_accessor :destination_attribute, :source, :source_attributes, :transformations
    
    def initialize(destination_attribute, source = nil, source_attributes = nil, transformations = nil)
      @destination_attribute = destination_attribute.to_s.to_sym
      @source = source
      @source_attributes = Array.wrap(source_attributes.map { |a| a.to_s.to_sym })
      @transformations = Array.wrap(transformations)
    end
    
    
    def value(source_row)
      value = source_attributes.map do |source_attribute|
        source_row.send(source_attribute)
      end
      transformations.each do |t|
        value = Array.wrap(t.transform(*value))
      end
      value.first
    end

  end
end
