require_relative 'piece'

class Pawn < Piece

    def symbol
        '♟'.colorize(color)
    end

    def moves
        forward_steps + side_attacks
    end

    def at_start_row?
        @pos[0] == (@color == :white ? 6 : 1)
    end

    def forward_dir
        color == :white ? -1 : 1
    end

    def forward_steps
        valid_steps = []
        piece_x, piece_y = @pos
        one_step = piece_x + forward_dir, piece_y
        two_steps = piece_x + 2 * forward_dir, piece_y
        valid_steps << one_step if @board.valid_pos?(one_step) && @board.empty?(one_step)
        valid_steps << two_steps if at_start_row? && @board.empty?(two_steps)
        valid_steps
    end
    
    def side_attacks
        piece_x, piece_y = @pos
        posibble_attacks = [
            [piece_x + forward_dir, piece_y - 1], 
            [piece_x + forward_dir, piece_y + 1]
        ]
        posibble_attacks.select do |attack_pos|
            next false unless @board.valid_pos?(attack_pos)
            next false if @board.empty?(attack_pos) || @board[attack_pos].color == @color
            true
        end
    end

end