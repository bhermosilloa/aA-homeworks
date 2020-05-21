require_relative 'board'
require_relative 'display'
require_relative 'human_player'
require_relative 'player'
require_relative 'ai_player'

class Game
    
    def initialize
        create_game
    end
    
    def play
        war_between_players until checkmate
        print_result_of_game
    end
    
    private
    
    attr_reader :display, :board, :player_1, :player_2
    attr_accessor :current_player

    def create_game
        @board = Board.new
        @display = Display.new(@board)
        @player_1 = HumanPlayer.new(:white, @display)
        @player_2 = HumanPlayer.new(:black, @display)
        @current_player = @player_1
    end

    def swap_turn!
        self.current_player = current_player == player_1 ? player_2 : player_1
    end

    def checkmate
        board.checkmate?(current_player.color)
    end

    def make_player_move
        start_pos, end_pos = current_player.make_move(board)
        board.move_piece(current_player.color, start_pos, end_pos)
    end

    def tell_player_wrong_move(e)
        puts "#{e.message}"
        sleep(1)
    end

    def print_board
        display.render
    end

    def win_message
        puts "#{(current_player == player_1 ? player_2 : player_1).color.capitalize} wins!"
    end

    def war_between_players
        player_move
        swap_turn!
    end

    def player_move
        begin
            make_player_move
        rescue StandardError => e
            tell_player_wrong_move(e)
            retry
        end
    end

    def print_result_of_game
        print_board
        win_message
        nil
    end

end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end
