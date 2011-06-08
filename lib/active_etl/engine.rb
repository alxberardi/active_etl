module ActiveETL
  class Engine
    
    def self.acts_like_source?(klass)
      klass.instance_methods.include?(:id)
      klass.respond_to?(:find)
    end
    
    
    
    
    
  end
end
