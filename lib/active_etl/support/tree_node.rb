# To change this template, choose Tools | Templates
# and open the template in the editor.

module ActiveETL
  module Support
    module TreeNode
      
      def parent
        @parent
      end
      
      
      def parent=(parent)
        @parent = validate_parent!(parent)
      end
      
      
      def children
        @children ||= []
      end
      
      
      def add_child(child)
        validate_node!(child).parent = self
        children << child
      end
      
      
      def <<(child)
        add_child(child)
      end
      
      
      def add_children(*children)
        add_children_array(children)
      end
      
      
      def add_children_array(children)
        children.each { |c| add_child(c) }
      end
      
      
      def remove_child(child)
        child = children.delete(child)
        child && child.parent = nil
        child
      end
      
      
      def siblings
        parent && parent.children - [self]
      end
      
      
      def next_sibling
        return nil if root?
        
        node_index = parent.children.index(self)
        parent.children.at(node_index + 1) if node_index
      end
      
      
      def previous_sibling
        return nil if root?
        
        node_index = parent.children.index(self)
        parent.children.at(node_index - 1) if node_index && node_index > 0
      end
      
      
      def leaf?
        children.blank?
      end


      def root?
        parent.nil?
      end
      

      def root
        node = self
        node = node.parent while node.parent
        node
      end


      def leafs
        if children.blank?
          [self]
        else
          children.map(&:leafs).flatten
        end
      end
      
      
      def height
        leaf? ? 0 : 1 + children.map { |child| child.height }.max
      end
      
      
      def depth
        root? ? 0 : 1 + parent.depth
      end
      
      
      def breadth
        root? ? 1 : parent.children.size
      end

      
      def size
        children.inject(1) { |sum, node| sum + node.size }
      end

      alias_method :level, :depth
      alias_method :levels, :height
      
      
      def level_nodes(level)
        if level.zero?
          [self]
        else
          children.map { |c| c.level_nodes(level - 1) }.flatten
        end
      end
      
      
      def preordered_each(&action)
        each_node &action
      end
      
      
      def breadth_each(&action)
        queue = [self]
        
        until queue.empty?
          next_node = queue.shift
          action.call next_node
          next_node.children { |child| queue.push child }
        end
      end


      def each_node(&action)
        action.call self
        each_descendant &action
      end


      def each_node_reverse(&action)
        each_descendant &action
        action.call self
      end


      def each_descendant(&action)
        children.each { |c| c.each_node &action }
      end


      def each_descendant_reverse(&action)
        children.each { |c| c.each_node_reverse &action }
      end


      def each_node_to_root(&action)
        action.call self
        each_parent &action
      end


      def each_parent(&action)
        parent.each_node_to_root &action if parent
      end


      def each_node_to_root_reverse(&action)
        each_parent &action
        action.call self
      end


      def each_parent_reverse(&action)
        parent.each_node_to_root_reverse &action if parent
      end


      def each_node_to_root_map(&action)
        map = []
        each_node_to_root { |n| map << action.call(n) }
        map
      end


      def each_parent_map(&action)
        map = []
        each_parent { |n| map << action.call(n) }
        map
      end


      def tree_map(&action)
        map = []
        each_node { |n| map << action.call(n) }
        map
      end


      def descendants_tree_map(&action)
        map = []
        each_descendant { |n| map << action.call(n) }
        map
      end


      def find_node(&condition)
        each_node do |n|
          return n if condition && condition.call(n)
        end
        nil
      end


      def find_all_nodes(&condition)
        nodes = []
        each_node do |n|
          nodes << n if condition && condition.call(n)
        end
        nodes
      end
      
      
      protected
      
      def validate_parent!(node)
        node.nil? ? nil : validate_node(node)
      end
      
      
      def validate_node!(node)
        raise Exception, "#{node} is not a tree node" unless node.class <= ActiveETL::Support::TreeNode
        node
      end

    end
  end
end
