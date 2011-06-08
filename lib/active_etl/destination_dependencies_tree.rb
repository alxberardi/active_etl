require 'active_etl/support/tree_node'

module ActiveETL
  class DestinationDependenciesTree
    
    include ActiveETL::Support::TreeNode
    
    attr_reader :destination
    
    def initialize(destination)
      @destination = destination
      @children = destination.etl_destination_dependencies.map do |d|
        DestinationDependenciesTree.new(d)
      end
    end
    
  end
end
