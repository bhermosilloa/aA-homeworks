require "hand"
require "card"

describe Hand do

    let(:cards) do
        [
            Card.new("5", :diamonds),
            Card.new("2", :spades),
            Card.new("7", :clubs),
            Card.new("8", :diamonds),
            Card.new("5", :hearts)
        ]
    end

    subject(:hand) { Hand.new(cards) }

    describe "initialize" do
        it "has 5 cards" do
            expect(hand.cards.count).to eq(5)
        end

        it "raises error if doesn't have 5 cards" do
            expect {Hand.new([Card.new("5", :spades)])}.to raise_error("Hand has to have 5 cards")
        end
    end

    let(:high_card) do
        [
            Card.new("K", :diamonds),
            Card.new("2", :spades),
            Card.new("J", :clubs),
            Card.new("8", :diamonds),
            Card.new("5", :hearts)
        ]
    end

    let(:weaker_high_card) do
        [
            Card.new("4", :diamonds),
            Card.new("Q", :spades),
            Card.new("J", :clubs),
            Card.new("8", :diamonds),
            Card.new("5", :hearts)
        ]
    end

    let(:one_pair) do
        [
            Card.new("5", :diamonds),
            Card.new("2", :spades),
            Card.new("7", :clubs),
            Card.new("8", :diamonds),
            Card.new("5", :hearts)
        ]
    end

    let(:weaker_one_pair) do
        [
            Card.new("3", :diamonds),
            Card.new("2", :spades),
            Card.new("7", :clubs),
            Card.new("8", :diamonds),
            Card.new("3", :hearts)
        ]
    end

    let(:two_pair) do
        [
            Card.new("5", :diamonds),
            Card.new("Q", :spades),
            Card.new("8", :clubs),
            Card.new("8", :diamonds),
            Card.new("5", :hearts)
        ]
    end

    let(:weaker_two_pair) do
        [
            Card.new("4", :diamonds),
            Card.new("A", :spades),
            Card.new("8", :clubs),
            Card.new("8", :diamonds),
            Card.new("4", :hearts)
        ]
    end

    let(:three_of_a_kind) do
        [
            Card.new("5", :diamonds),
            Card.new("5", :spades),
            Card.new("J", :clubs),
            Card.new("5", :clubs),
            Card.new("3", :hearts)
        ]
    end

    let(:weaker_three_of_a_kind) do
        [
            Card.new("4", :diamonds),
            Card.new("4", :spades),
            Card.new("Q", :clubs),
            Card.new("4", :clubs),
            Card.new("3", :hearts)
        ]
    end

    let(:straight) do
        [
            Card.new("5", :diamonds),
            Card.new("8", :spades),
            Card.new("6", :clubs),
            Card.new("7", :diamonds),
            Card.new("9", :hearts)
        ]
    end

    let(:weaker_straight) do
        [
            Card.new("2", :diamonds),
            Card.new("3", :spades),
            Card.new("A", :clubs),
            Card.new("5", :diamonds),
            Card.new("4", :hearts)
        ]
    end

    let(:flush) do
        [
            Card.new("5", :diamonds),
            Card.new("2", :diamonds),
            Card.new("7", :diamonds),
            Card.new("8", :diamonds),
            Card.new("K", :diamonds)
        ]
    end

    let(:weaker_flush) do
        [
            Card.new("4", :spades),
            Card.new("2", :spades),
            Card.new("7", :spades),
            Card.new("8", :spades),
            Card.new("K", :spades)
        ]
    end

    let(:full_house) do
        [
            Card.new("A", :diamonds),
            Card.new("A", :spades),
            Card.new("K", :clubs),
            Card.new("A", :hearts),
            Card.new("K", :hearts)
        ]
    end

    let(:weaker_full_house) do
        [
            Card.new("Q", :diamonds),
            Card.new("Q", :spades),
            Card.new("K", :clubs),
            Card.new("Q", :hearts),
            Card.new("K", :hearts)
        ]
    end

    let(:poker) do
        [
            Card.new("A", :diamonds),
            Card.new("2", :spades),
            Card.new("A", :clubs),
            Card.new("A", :spades),
            Card.new("A", :hearts)
        ]
    end

    let(:weaker_poker) do
        [
            Card.new("K", :diamonds),
            Card.new("2", :spades),
            Card.new("K", :clubs),
            Card.new("K", :spades),
            Card.new("K", :hearts)
        ]
    end

    let(:straight_flush) do
        [
            Card.new("9", :spades),
            Card.new("J", :spades),
            Card.new("7", :spades),
            Card.new("8", :spades),
            Card.new("10", :spades)
        ]
    end

    let(:weaker_straight_flush) do
        [
            Card.new("A", :spades),
            Card.new("3", :spades),
            Card.new("4", :spades),
            Card.new("2", :spades),
            Card.new("5", :spades)
        ]
    end

    describe "#hand" do
        it "returns the highest hand that cards make" do
            expect(Hand.new(straight_flush).hand).to eq(:straight_flush)
            expect(Hand.new(poker).hand).to eq(:poker)
            expect(Hand.new(full_house).hand).to eq(:full_house)
            expect(Hand.new(flush).hand).to eq(:flush)
            expect(Hand.new(straight).hand).to eq(:straight)
            expect(Hand.new(three_of_a_kind).hand).to eq(:three_of_a_kind)
            expect(Hand.new(two_pair).hand).to eq(:two_pair)
            expect(Hand.new(one_pair).hand).to eq(:one_pair)
            expect(Hand.new(high_card).hand).to eq(:high_card)
        end
    end

    describe '::winner' do
        let(:flush_h) { Hand.new(flush) }
        let(:straight_flush_h) { Hand.new(straight_flush) }
        let(:one_pair_h) { Hand.new(one_pair) }
        let(:high_card_h) { Hand.new(high_card) }
        let(:three_of_a_kind_h) { Hand.new(three_of_a_kind) }

      it 'returns the winner hand' do
        play_hands = [flush_h, straight_flush_h, one_pair_h]
        expect(Hand.winner(play_hands)).to eq(Hand.new(straight_flush))

        play_2_hands = [one_pair_h, high_card_h, three_of_a_kind_h]
        expect(Hand.winner(play_2_hands)).to eq(three_of_a_kind_h)
      end
    end

    describe "#change_cards" do
        let(:discard_cards) { hand.cards[0..2] }
        let(:new_cards) { [Card.new("5", :clubs), Card.new("A", :spades), Card.new("K", :spades)] }

        it "throws chosen cards" do
            hand.change_cards(discard_cards, new_cards)
            expect(hand.cards.none? { |card| discard_cards.any? { |disc_card| disc_card.object_id == card.object_id } }).to eq(true)
        end

        it "receive new cards" do
            hand.change_cards(discard_cards, new_cards)
            expect(hand.cards.count { |card| new_cards.any? { |new_card| new_card.object_id == card.object_id } } == new_cards.count).to eq(true)
        end

        it "raises an error if hand doesn't end with five cards" do
            expect do
                hand.change_cards(hand.cards[0..1], new_cards)
            end.to raise_error "hand must have five cards"
        end

        it "raises an error if throws invalid cards" do
            expect do
                hand.change_cards([Card.new("3", :spades)], [Card.new("5", :clubs)])
            end.to raise_error "invalid trashed card - must throw existing card"
        end
    end

    describe "#<=>" do
        it "returns 1 if hand is stronger" do
            expect(Hand.new(straight_flush) <=> Hand.new(flush)).to eq(1)
            expect(Hand.new(high_card) <=> Hand.new(weaker_high_card)).to eq(1)
            expect(Hand.new(one_pair) <=> Hand.new(weaker_one_pair)).to eq(1)
            expect(Hand.new(two_pair) <=> Hand.new(weaker_two_pair)).to eq(1)
            expect(Hand.new(three_of_a_kind) <=> Hand.new(weaker_three_of_a_kind)).to eq(1)
            expect(Hand.new(straight) <=> Hand.new(weaker_straight)).to eq(1)
            expect(Hand.new(flush) <=> Hand.new(weaker_flush)).to eq(1)
            expect(Hand.new(full_house) <=> Hand.new(weaker_full_house)).to eq(1)
            expect(Hand.new(poker) <=> Hand.new(weaker_poker)).to eq(1)
            expect(Hand.new(straight_flush) <=> Hand.new(weaker_straight_flush)).to eq(1)
        end
        
        it "returns -1 if hand is weaker" do
            expect(Hand.new(high_card) <=> Hand.new(three_of_a_kind)).to eq(-1)
            expect(Hand.new(weaker_high_card) <=> Hand.new(high_card)).to eq(-1)
            expect(Hand.new(weaker_one_pair) <=> Hand.new(one_pair)).to eq(-1)
            expect(Hand.new(weaker_two_pair) <=> Hand.new(two_pair)).to eq(-1)
            expect(Hand.new(weaker_three_of_a_kind) <=> Hand.new(three_of_a_kind)).to eq(-1)
            expect(Hand.new(weaker_straight) <=> Hand.new(straight)).to eq(-1)
            expect(Hand.new(weaker_flush) <=> Hand.new(flush)).to eq(-1)
            expect(Hand.new(weaker_full_house) <=> Hand.new(full_house)).to eq(-1)
            expect(Hand.new(weaker_poker) <=> Hand.new(poker)).to eq(-1)
            expect(Hand.new(weaker_straight_flush) <=> Hand.new(straight_flush)).to eq(-1)
        end
        
        it "returns 0 if hands are equal strength" do
            expect(Hand.new(high_card) <=> Hand.new(high_card)).to eq(0)
            expect(Hand.new(one_pair) <=> Hand.new(one_pair)).to eq(0)
            expect(Hand.new(two_pair) <=> Hand.new(two_pair)).to eq(0)
            expect(Hand.new(three_of_a_kind) <=> Hand.new(three_of_a_kind)).to eq(0)
            expect(Hand.new(straight) <=> Hand.new(straight)).to eq(0)
            expect(Hand.new(flush) <=> Hand.new(flush)).to eq(0)
            expect(Hand.new(full_house) <=> Hand.new(full_house)).to eq(0)
            expect(Hand.new(poker) <=> Hand.new(poker)).to eq(0)
            expect(Hand.new(straight_flush) <=> Hand.new(straight_flush)).to eq(0)
        end
    end

end