require 'active_etl/transformation'

module ActiveETL
  class ProcTransformation < Transformation
    
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
