require_relative 'display'
require_relative 'player'

class HumanPlayer < Player

    def make_move(board)
        start_pos, end_pos = nil, nil

        until start_pos && end_pos
            print_board
            announce_if_player_in_check(board)
            if start_pos
                puts "#{color.capitalize}'s turn. Where do you want to place your piece?"
                end_pos = select_position
            else
                puts "#{color.capitalize}'s turn. What piece do you want to move?"
                start_pos = select_position
            end
        end
        
        [start_pos, end_pos]
    end

    private

    def print_board
        display.render
    end

    def announce_if_player_in_check(board)
        puts "#{color.capitalize}, you are in CHECK!" if board.in_check?(color)
    end

    def select_position
        display.cursor.get_input
    end

end