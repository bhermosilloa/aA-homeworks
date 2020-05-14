require_relative 'tic_tac_toe'

class TicTacToeNode

  BOARD_MOVES = (0..2).to_a.product((0..2).to_a)

  attr_reader :next_mover_mark, :board

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    BOARD_MOVES.select { |pos| @board.empty?(pos) }.map do |empty_pos| 
      board = self.board.dup
      board[empty_pos] = self.next_mover_mark
      @next_mover_mark = self.next_mover_mark == :x ? :o : :x
      @prev_move_pos = empty_pos
      self.class.new(board, @next_mover_mark, @prev_move_pos)
    end
  end

end
