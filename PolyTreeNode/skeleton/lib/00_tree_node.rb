require "byebug"

class PolyTreeNode
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent)
        @parent.children.delete(self) unless @parent.nil?
        @parent = parent
        unless @parent.nil?
            @parent.children << self unless @parent.children.include?(self)
        end
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        raise "Node is not a child" if child.parent.nil?
        child.parent = nil
    end

    def dfs(target_value)
        return self if @value == target_value
        @children.each do |child| 
            search_result = child.dfs(target_value)
            return search_result unless search_result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            shifted_node = queue.shift
            return shifted_node if target_value == shifted_node.value
            shifted_node.children.each { |child| queue << child }
        end
        nil
    end
end