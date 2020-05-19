class NoPieceInPosition < StandardError
    def message
        "There is no piece at entered position"
    end
end

class InvalidPieceMove < StandardError
    def message
        "This piece cannot be moved into entered position"
    end
end

class InvalidColorPiece < StandardError
    def message
        "You must move one of your pieces"
    end
end

class MovingIntoCheck < StandardError
    def message
        "You cannot move into check"
    end
end