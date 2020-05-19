require 'colorize'

class Piece

    attr_accessor :pos
    attr_reader :color, :board

    def initialize(color, board, pos)
        @color, @board, @pos = color, board, pos

        @board.add_piece(self, pos)
    end

    def to_s
        " #{symbol} "
    end

    def empty?
        false
    end
    
    def valid_moves
        moves.reject { |end_pos| move_into_check?(end_pos) }
    end

    def move_into_check?(end_pos)
        test_board = @board.dup
        test_board.move_piece!(@pos, end_pos)
        test_board.in_check?(@color)
    end

    def symbol
        # This method gets implemented in a subclass (it returns a unicode chess char in the piece's color)
    end

    def inspect
        "#{@color.capitalize} #{self.class} - #{@pos}".inspect
    end

end