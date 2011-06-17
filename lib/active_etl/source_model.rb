require 'active_record'
require 'active_etl/source'

module ActiveETL
  class SourceModel < Source
    
    attr_accessor :model, :finder_options
    
    def initialize(model, options = {})
      self.model = model
      self.finder_options = options[:finder_options]
      add_destination_attributes(options[:destination_attributes])
    end
    
    
    def source
      model.name.underscore
    end
    
    
    def model=(model)
      model_class = if model.is_a?(Class)
        model
      else
        model.to_s.classify.constantize
      end
      
      raise Exception, "#{model_class} is not a #{ActiveRecord::Base.name}" unless model_class.is_a?(ActiveRecord::Base)
      
      @model = model_class
    end
    
    
    def source=(model)
      self.model = model
    end
    
    
    def primary_key
      model.primary_key
    end
    
      
    def find(&block)
      model.find_in_batches(finder_options, &block)
    end
    
  end
end
