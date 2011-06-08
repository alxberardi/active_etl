require 'active_etl/destination_dependencies_tree'

module ActiveETL
  class Job
    
    attr_accessor :destinations
    
    def initialize(destinations)
      self.destinations=(destinations)
    end
    
    
    def destinations=(destinations)
      @destinations = Array.wrap(destinations).map do |d|
        destination_class = if d.is_a?(String) || d.is_a?(Symbol)
          d.to_s.classify.constantize
        else
          d
        end
        
        raise Exception, "#{destination_class} is not a valid destination" unless d <= ActiveETL::Destination
        
        destination_class
      end
    end
    
    
    def execution_tree
      @execution_tree ||= create_execution_tree
    end
    
    
    private
    
    def create_execution_tree
      dependencies_tree = @destinations.map { |d| DestinationDependenciesTree.new(d) }
#      dependencies_array = (@destinations + @destinations.map(&:etl_destination_dependencies)).flatten.uniq
#      tree = []
#      until dependencies_array.blank?
#        current_level = []
#        dependencies_array.reverse_each do |t|
#          if (t.etl_destination_dependencies - tree.flatten).blank?
#            current_level << t
#            dependencies_array.delete(t)
#          end
#        end
#        tree << current_level
#      end
#      tree
    end
  end
end
