module ActiveETL
  class DestinationDependenciesTree
    
    include RTree::TreeNode
    
    attr_reader :destination
    
    def initialize(destination)
      @destination = destination
      @children = destination.etl_destination_dependencies.map do |d|
        DestinationDependenciesTree.new(d)
      end
    end
    
    
    def content
      destination
    end
    
    
    def to_s
      destination.to_s
    end
    
  end
end
