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