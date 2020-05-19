module Slideable

    HORIZONTAL_AND_VERTICAL_MOVES = [
        [-1, 0],
        [0, -1],
        [0, 1],
        [1, 0]
    ].freeze

    DIAGONAL_MOVES = [
        [-1, -1],
        [-1, 1],
        [1, -1],
        [1, 1]
    ].freeze

    def horizontal_and_vertical_moves
        HORIZONTAL_AND_VERTICAL_MOVES
    end

    def diagonal_moves
        DIAGONAL_MOVES
    end

    def moves
        move_dirs.each_with_object([]) { |(x, y), moves| moves.concat(all_valid_moves_in_one_direction(x, y)) }
    end

    def all_valid_moves_in_one_direction(x, y)
        valid_moves = []
        piece_x, piece_y = @pos
        loop do
            piece_x, piece_y = piece_x + x, piece_y + y
            pos = piece_x, piece_y

            break unless @board.valid_pos?(pos)

            if @board.empty?(pos)
                valid_moves << pos
            else
                valid_moves << pos if @board[pos].color != @color
                break
            end
        end
        valid_moves
    end

    def move_dirs
        # This method gets implemented in a subclass
    end

end