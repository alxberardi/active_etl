require 'active_etl/destination_dependencies_tree'

module ActiveETL
  class JobExecutionSequence
    
    attr_reader :sequence
    
    def initialize(destinations)
      @sequence = []
      dependencies_trees = destinations.map { |d| DestinationDependenciesTree.new(d) }
      max_height = dependencies_trees.map(&:height).max
      (max_height + 1).times do |i|
        @sequence << dependencies_trees.map { |t| t.height_nodes(i).map(&:destination) }.flatten.uniq
      end
    end
    
    
    def each_destination_in_sequence(&block)
      @sequence.each do |level|
        level.each do |destination|
          block.call(destination)
        end
      end
    end
    
  end
end
