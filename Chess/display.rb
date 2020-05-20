require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def build_grid
        @board.rows.map.with_index do |row, x|
            build_row(row, x)
        end
    end

    def build_row(row, x)
        row.map.with_index do |piece, y|
            color_options = colors_for(x, y)
            piece.to_s.colorize(color_options)
        end
    end

    def colors_for(x, y)
        if [x, y] == @cursor.cursor_pos
            bg = @cursor.selected ? :light_green : :light_red
        elsif (x + y).odd?
            bg = :light_blue
        else
            bg = :blue
        end
        { background: bg }
    end

    def render
        system("clear")
        build_grid.each { |row| puts row.join }
    end

    def loop_render
        loop do
            self.render
            @cursor.get_input
        end
    end

end

if $PROGRAM_NAME == __FILE__

  board = Board.new
  display = Display.new(board)

  display.loop_render

end