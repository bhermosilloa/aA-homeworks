require "card"

describe Card do
    subject(:card1) { Card.new("A", :spades) }

    describe "#initialize" do
        it "assigns card's rank and suit" do
            expect(card1.rank).to eq("A")
            expect(card1.suit).to eq(:spades)
        end

        it "raises an error with an invalid suit" do
            expect { Card.new("A", :hello) }.to raise_error
        end

        it "raises an error with an invalid rank" do
            expect { Card.new("G", :spades) }.to raise_error
        end
    end

    describe "#to_s" do
        it "returns card's rank and suit's symbol" do
            expect(card1.to_s).to eq("A♠")
        end
    end

    describe "#<=>" do
        let(:card2) { Card.new("J", :diamonds) }
        let(:card3) { Card.new("A", :clubs) }
        it "should return 0 when cards are the same" do
            expect(card1<=>card3).to eq(0)
        end

        it "should return 1 when card has higher value" do
            expect(card1<=>card2).to eq(1)
        end

        it "should return -1 when card has lower value" do
            expect(card2<=>card1).to eq(-1)
        end
    end

end