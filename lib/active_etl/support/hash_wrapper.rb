module RubyExtensions
  
  module HashAdapter
    
    def method_missing(method_id, *arguments, &block)
      if method_id.id2name.ends_with?('=')
        self[method_id.to_s.chop.to_sym] = arguments.first
      else
        self[method_id]
      end
    end
    
  end
  
  
  class HashWrapper

    attr_accessor :hash

    def initialize(hash = nil)
      self.hash = hash
    end


    def hash=(hash)
      @hash = if hash
        raise Exception, "#{hash} is not a hash" unless hash.is_a?(Hash)
        hash
      else
        {}
      end
    end


    def method_missing(method_id, *arguments, &block)
      if method_id.id2name.ends_with?('=')
        hash[method_id.to_s.chop.to_sym] = arguments.first
      else
        hash[method_id]
      end
    end

  end
end
