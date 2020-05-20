require_relative 'piece_package'
require_relative 'exceptions'

class Board

    attr_reader :rows

    def initialize(fill_with_pieces = true)
        @sentinel = NullPiece.instance
        @rows = Array.new(8) { Array.new(8, @sentinel) }
        fill_board_with_pieces if fill_with_pieces
    end
    
    def [](pos)
        @rows[pos[0]][pos[1]]
    end
    
    def []=(pos, val)
        @rows[pos[0]][pos[1]] = val
    end
    
    def add_piece(piece, pos)
        self[pos] = piece
    end
    
    def move_piece(color_in_turn, start_pos, end_pos)
        raise InvalidPositionError unless valid_pos?(start_pos)
        raise NoPieceInPositionError if empty?(start_pos)
        
        piece = self[start_pos]
        if piece.color != color_in_turn
            raise InvalidColorPieceError 
        elsif !piece.moves.include?(end_pos)
            raise InvalidPieceMoveError
        elsif !piece.valid_moves.include?(end_pos)
            raise MovingIntoCheckError
        end
        move_piece!(start_pos, end_pos)
    end
    
    def move_piece!(start_pos, end_pos)
        piece = self[start_pos]
        self[start_pos] = @sentinel
        self[end_pos] = piece
        piece.pos = end_pos
    end

    def empty?(pos)
        self[pos].empty?
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0,7) }
    end
    
    def checkmate?(color)
        return false unless in_check?(color)
        pieces.select { |piece| piece.color == color }.all? do |piece|
            piece.valid_moves.empty?
        end
    end
    
    def in_check?(color)
        king_pos = find_king(color)
        pieces.any? { |piece| piece.moves.include?(king_pos) }
    end
    
    def find_king(color)
        pieces.find { |piece| piece.color == color && piece.class == King }.pos
    end
    
    def pieces
        @rows.flatten.reject(&:empty?)
    end
    
    def dup
        dup_board = Board.new(false)
        pieces.each { |piece| piece.class.new(piece.color, dup_board, piece.pos) }
        dup_board
    end
    
    private

    def fill_board_with_pieces
        %i(white black).each do |color|
            fill_back_row(color)
            fill_pawn_row(color)
        end
    end

    def fill_back_row(color)
        pieces_in_order = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        row = color == :white ? 7 : 0
        pieces_in_order.each_with_index do |piece, col|
            piece.new(color, self, [row, col])
        end
    end

    def fill_pawn_row(color)
        row = color == :white ? 6 : 1
        (0..7).each { |col| Pawn.new(color, self, [row, col]) }
    end

    def inspect
        "Board".inspect
    end

end