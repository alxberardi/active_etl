module ActiveETL
  class ProcTransformation < ActiveETL::Transformation
    
    def initialize(&proc)
      @proc = proc
    end
    
    
    def transform(*values)
      if @proc.is_a?(Proc)
        @proc.call(*values)
      end
    end
    
  end
end
