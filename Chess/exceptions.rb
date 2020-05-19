class NoPieceInPositionError < StandardError
    def message
        "There is no piece at entered position"
    end
end

class InvalidPieceMoveError < StandardError
    def message
        "This piece cannot be moved into entered position"
    end
end

class InvalidColorPieceError < StandardError
    def message
        "You must move one of your pieces"
    end
end

class MovingIntoCheckError < StandardError
    def message
        "You cannot move into check"
    end
end

class InvalidPositionError < StandardError
    def message
        "Position out of bounds"
    end
end