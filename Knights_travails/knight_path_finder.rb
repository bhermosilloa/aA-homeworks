require_relative "../PolyTreeNode/lib/00_tree_node"

class KnightPathFinder

    DELTAS = [[2, 1], [1, 2], [-1, 2], [-1, -2], [-2, -1], [2, -1], [1, -2], [-2, 1]]

    def self.valid_moves(pos)
        DELTAS.map do |dx, dy|
            [pos[0] + dx, pos[1] + dy]
        end.select do |row, col|
            [row, col].all? { |coord| coord.between?(0, 7) }
        end
    end
    
    def initialize(starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_positions = [starting_pos]

        build_move_tree
    end

    def find_path(end_pos)
        end_node = @root_node.dfs(end_pos)
        trace_path_back(end_node).reverse
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            shifted_node = queue.shift
            new_move_positions(shifted_node.value).each do |position|
                new_node = PolyTreeNode.new(position)
                new_node.parent = shifted_node
                queue << new_node
            end
        end
    end

    def new_move_positions(pos)
        new_move_positions = KnightPathFinder.valid_moves(pos).reject { |coord| @considered_positions.include?(coord) }
        @considered_positions += new_move_positions
        new_move_positions
    end

    def trace_path_back(node)
        path = [node.value]
        return path if node.parent.nil?
        path += trace_path_back(node.parent)
    end

    def inspect
        "Knight Path".inspect
    end

end