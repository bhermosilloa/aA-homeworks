module Stepable

    def moves
        move_dirs.each_with_object([]) do |(x, y), valid_moves|
            piece_x, piece_y = @pos
            piece_x, piece_y = piece_x + x, piece_y + y
            pos = piece_x, piece_y
            if @board.valid_pos?(pos)
                if @board.empty?(pos)
                    valid_moves << pos
                else
                    valid_moves << pos if @board[pos].color != @color
                end
            end
        end
    end

    def move_dirs
        # This method gets implemented in a subclass
    end

end