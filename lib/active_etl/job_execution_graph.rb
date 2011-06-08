require 'active_etl/destination_dependencies_tree'

module ActiveETL
  class JobExecutionGraph
    
    def initialize(destinations)
      dependencies_trees = destinations.map { |d| DestinationDependenciesTree.new(d) }
    end
  end
end
