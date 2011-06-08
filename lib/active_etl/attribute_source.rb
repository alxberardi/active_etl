module ActiveETL
  class AttributeSource

    attr_reader :attribute, :source, :source_attributes, :transformations
    
    def initialize(attribute, source = nil, source_attributes = nil, transformations = nil)
      @attribute = attribute.to_s.to_sym
      @source = source
      @source_attributes = Array.wrap(source_attributes)
      @transformations = Array.wrap(transformations)
    end

  end
end
