require_relative "piece"
require_relative "exceptions"
require 'byebug'

class Board

    def initialize
        @rows = Array.new(8) { Array.new(8) }
        (0..7).each do |row|
            (0..7).each do |col|
                if row == 0 || row == 7
                    self[[row, col]] = Piece.new("Rook") if col == 0 || col == 7
                    self[[row, col]] = Piece.new("Knight") if col == 1 || col == 6
                    self[[row, col]] = Piece.new("Bishop") if col == 2 || col == 5
                    self[[row, col]] = Piece.new("Queen") if col == 3
                    self[[row, col]] = Piece.new("King") if col == 4
                elsif row == 1 || row == 6
                    self[[row, col]] = Piece.new("pawn")
                else
                    self[[row, col]] = nil
                end
            end
        end
    end

    def [](pos)
        @rows[pos[0]][pos[1]]
    end

    def []=(pos, val)
        row, col = pos  
        @rows[row][col] = val
    end

    def move_piece(start_pos, end_pos)
        raise NoPieceInPosition if self[start_pos].nil?
        raise InvalidPieceMove if !self[end_pos].nil?
        piece = self[start_pos]
        self[start_pos] = nil
        self[end_pos] = piece
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0,7) }
    end

    def add_piece(piece, pos)
    end

end