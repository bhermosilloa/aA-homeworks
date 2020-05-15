require_relative 'tic_tac_toe'

class TicTacToeNode

  BOARD_MOVES = (0..2).to_a.product((0..2).to_a)

  attr_reader :next_mover_mark, :board, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      if @board.winner != evaluator && !@board.winner.nil?
        return true
      else
        return false
      end
    end
    if self.next_mover_mark == evaluator
      return self.children.all? { |node| node.losing_node?(evaluator) }
    else
      return self.children.any? { |node| node.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      if @board.winner == evaluator
        return true
      else
        return false
      end
    end
    if self.next_mover_mark == evaluator
      return self.children.any? { |node| node.winning_node?(evaluator) }
    else
      return self.children.all? { |node| node.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    opponents_mark = (self.next_mover_mark == :x) ? :o : :x
    BOARD_MOVES.select { |pos| self.board.empty?(pos) }.map do |empty_pos|
      dup_board = @board.dup 
      dup_board[empty_pos] = self.next_mover_mark
      self.class.new(dup_board.dup, opponents_mark, empty_pos)
    end
  end

end
