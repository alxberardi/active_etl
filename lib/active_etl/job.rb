require 'active_etl/job_execution_sequence'

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
        
        raise Exception, "#{destination_class} is not a #{ActiveETL::Destination.name}" unless d <= ActiveETL::Destination
        
        destination_class
      end
    end
    
    
    def execution_sequence
      @execution_sequence ||= ActiveETL::JobExecutionSequence.new(@destinations)
    end
    
    
    def execute
      execution_sequence.each_destination_in_sequence(&:run_etl)
    end
    
  end
end
