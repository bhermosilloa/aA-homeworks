require_relative 'display'
require_relative 'player'

class AiPlayer < Player

    def make_move(board)
        @board = board
        start_pos, end_pos = nil, nil

        until start_pos && end_pos
            display.render
            announce_if_player_in_check
            if start_pos
                end_pos = select_end_position
            else
                start_pos = select_start_position
            end
            sleep(0.0005)
        end
        
        [start_pos, end_pos]
    end

    private

    attr_reader :board
    attr_accessor :selected_piece

    def announce_if_player_in_check
        puts "#{color.capitalize}, you are in CHECK!" if board.in_check?(color)
    end

    def select_start_position
        @selected_piece = piece_with_opponent_in_target

        @selected_piece = random_piece if selected_piece.nil?

        selected_piece.pos
    end

    def select_end_position
        end_position = selected_piece.valid_moves.select do |position|
            opponent_pieces.include?(board[position])
        end.sample

        end_position.nil? ? selected_piece.valid_moves.sample : end_position
    end

    def opponent_pieces
        board.pieces.reject { |piece| piece.color == color }
    end

    def piece_with_opponent_in_target
        board.pieces.select do |piece| 
            piece.color == color
        end.reject do |piece| 
            piece.valid_moves.empty?
        end.select do |piece|
            piece.valid_moves.any? { |position| opponent_pieces.include?(board[position]) }
        end.sample
    end

    def random_piece
        board.pieces.select { |piece| piece.color == color }.reject { |piece| piece.valid_moves.empty? }.sample
    end

end