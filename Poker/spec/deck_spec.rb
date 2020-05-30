require "deck"

describe Deck do
    subject(:deck) { Deck.new }
    let(:fake_cards) { Deck.fill_deck }
    let(:card) { double("card", :suit => :diamonds, :rank => "10") }
    let(:cards) do
        [ double("card", :suit => :spades, :rank => "K"),
          double("card", :suit => :spades, :rank => "Q"),
          double("card", :suit => :spades, :rank => "J") ]
    end
    let(:small_deck) { Deck.new(cards.dup) }

    describe "#initialize" do
        it "has 52 cards" do
            expect(deck.count).to eq(52)
        end

        it "has 13 cards of each suit" do
            all_cards = %i(spades diamonds hearts clubs).all? do |card_suit|
                    fake_cards.count { |card| card.suit == card_suit } == 13
            end
            expect(all_cards).to eq(true)
        end

        it "has no duplicate cards" do
            expect(
                fake_cards.map { |card| [card.suit, card.rank] }.uniq.count
            ).to eq(deck.count)
        end

        it "can be initialized with an array of cards" do
            deck = Deck.new(cards)
            expect(deck.count).to eq(3)
        end
    end

    describe "#count" do
        it "returns number of cards in deck" do
            deck.take(1)
            expect(deck.count).to eq(51)
        end
    end

    describe "take" do
        it "returns top n cards of deck" do
            expect(small_deck.take(1).size).to eq(1)
        end

        it "take cards from top of deck" do
            expect(small_deck.take(1)).to eq(cards[0..0])
            expect(small_deck.take(2)).to eq(cards[1..2])
        end

        it "removes cards from deck when cards taken" do
            small_deck.take(1)
            expect(small_deck.count).to eq(2)
        end

        it "raises error if tries to take more cards than deck count" do
            expect do
                small_deck.take(4)
            end.to raise_error("not enough cards")
        end
    end

    describe "return" do
        let(:some_cards) do
        [ double("card", :suit => :clubs, :rank => "3"),
          double("card", :suit => :clubs, :rank => "6"),
          double("card", :suit => :clubs, :rank => "8") ]
        end

        it "adds cards to bottom of deck" do
            small_deck.return(some_cards)
            expect(small_deck.count).to eq(6)
            small_deck.take(3)
            expect(small_deck.take(1)).to eq(some_cards[0..0])
            expect(small_deck.take(1)).to eq(some_cards[1..1])
            expect(small_deck.take(1)).to eq(some_cards[2..2])
        end
    end

    describe "shuffle" do
        it "shuffles deck of cards" do
            shuffled = (0..10).all? do
                small_deck.shuffle!
                shuffled_cards = small_deck.take(3)
                small_deck.return(shuffled_cards)
                (0..2).all? { |idx| shuffled_cards[idx] == cards[idx] }
            end
            expect(small_deck).to be(small_deck)
            expect(shuffled).to be(false)
        end
    end

    describe "deal_hand" do
        it "returns a hand" do
            hand = deck.deal_hand
            expect(hand).to be_a(Hand)
        end

        it "reduces deck 5 cards" do
            deck.deal_hand
            expect(deck.count).to be(47)
        end
    end

end