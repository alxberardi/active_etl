module ActiveETL
  module SourceModel
      
    # Include class methods
    def self.included(base)
      base.send(:include, ActiveETL::Source)
      base.extend(ActiveETL::SourceModel::ClassMethods)
      super
    end
      
    
    module ClassMethods
      
    end
    
  end
end
