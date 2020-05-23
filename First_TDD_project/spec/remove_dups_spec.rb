require "remove_dups"

describe "my_uniq" do
    let(:array) { [1, 1, 2, 3, 3] }
    
    it "should raise an error if argument is not an array" do
        expect { my_uniq("") }.to raise_error(ArgumentError)
        expect { my_uniq(1000) }.to raise_error(ArgumentError)
    end

    it "should return the unique elements in the order in which they first appeared" do
        expect(my_uniq([1, 1, 1, 2, 3, 4, 4])).to eq([1, 2, 3, 4])
        expect(my_uniq([4, 1, 2, 2, 3, 1, 4])).to eq([4, 1, 2, 3])
        expect(my_uniq(["a", "b", 2, 2, "a", 1, "c"])).to eq(["a", "b", 2, 1, "c"])
        expect(my_uniq([1])).to eq([1])
        expect(my_uniq([])).to eq([])
    end

    it "should return a new array" do
        expect(my_uniq(array)).to_not be(array)
    end
end

describe Array do
    let(:array_1) { [-1, 0, 2, -2, 1] }
    let(:array_2) { [-1, -1, 2, -2, 1] }
    let(:array_3) { [-1, -1, -1, -1, 1] }
    let(:array_4) { [-1, 0, 2, -3, 5] }

    describe "two_sum" do
        it "should find all pairs of positions where the elements at those positions sum to zero" do
            expect(array_1.two_sum).to eq([[0, 4], [2, 3]])
            expect(array_2.two_sum).to eq([[0, 4], [1, 4], [2, 3]])
            expect(array_3.two_sum).to eq([[0, 4], [1, 4], [2, 4], [3, 4]])
            expect(array_4.two_sum).to eq([])
            expect([].two_sum).to eq([])
        end

        it "should raise an error if an element is not an integer" do
            expect { [1, -1, "a", "1", 2].two_sum }.to raise_error(ArgumentError)
        end
    end
end

describe "my_transpose" do
    let(:array) { [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
        ] }
        
    it "should raise an error if argument is not an array" do
        expect { my_transpose("") }.to raise_error(ArgumentError)
        expect { my_transpose(1000) }.to raise_error(ArgumentError)
    end
    
    it "should return the row/column equivalent version of the array" do
        expect(my_transpose(array)).to eq([
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8]
        ])
    end
end
    
describe "stock_picker" do
    let(:stocks_prices_1) { [100, 102, 101, 98, 97, 96, 99, 100, 103, 101, 96] }
    let(:stocks_prices_2) { [100, 102, 101, 96, 97, 96, 99] }
    let(:stocks_prices_3) { [100, 102, 101, 98, 97, 96, 97] }
    
    it "should raise an error if argument is not an array" do
        expect { my_transpose("") }.to raise_error(ArgumentError)
        expect { my_transpose(1000) }.to raise_error(ArgumentError)
    end
    
    it "should raise an error if an element is not an integer" do
        expect { [1, -1, "a", "1", 2].two_sum }.to raise_error(ArgumentError)
    end

    it "should return the most profitable pair of days on which to first buy the stock and then sell the stock" do
        expect(stock_picker(stocks_prices_1)).to eq([5, 8])
        expect(stock_picker(stocks_prices_2)).to eq([3, 6])
        expect(stock_picker(stocks_prices_3)).to eq([0, 1])
    end
end

describe TowersOfHanoi do
    subject(:game) { TowersOfHanoi.new(3) }

    describe "#initialize" do
        it "should create three arrays as instance variables" do
            expect(game.pile_1).to be_an(Array)
            expect(game.pile_2).to be_an(Array)
            expect(game.pile_3).to be_an(Array)
        end

        it "should fill the first pile with the number of discs especified in the correct order" do
            expect(game.pile_1).to eq([1, 2, 3])
        end
    end

    describe "#move" do
        it "should move the first disc of moving pile into top of receiving pile" do
            game.move(game.pile_1, game.pile_2)
            expect(game.pile_1).to eq([2, 3])
            expect(game.pile_2).to eq([1])
            game.move(game.pile_2, game.pile_3)
            expect(game.pile_1).to eq([2, 3])
            expect(game.pile_2).to eq([])
            expect(game.pile_3).to eq([1])
        end

        it "should raise an error if disc chosen is bigger than the top disc on the designed pile" do
            expect do 
                game.move(game.pile_1, game.pile_2)
                game.move(game.pile_1, game.pile_2)
            end.to raise_error(InvalidMove)
        end
    end

    describe "#won?" do
        it "should return true if all discs are on the final pile in order" do
            game.move(game.pile_1, game.pile_3)
            game.move(game.pile_1, game.pile_2)
            game.move(game.pile_3, game.pile_2)
            game.move(game.pile_1, game.pile_3)
            game.move(game.pile_2, game.pile_1)
            game.move(game.pile_2, game.pile_3)
            game.move(game.pile_1, game.pile_3)
            expect(game.won?).to eq(true)
        end

        it "should return false if not all discs are on the final pile in order" do
            game.move(game.pile_1, game.pile_3)
            game.move(game.pile_1, game.pile_2)
            game.move(game.pile_3, game.pile_2)
            game.move(game.pile_1, game.pile_3)
            expect(game.won?).to eq(false)
        end
    end
end