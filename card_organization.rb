module Cribbage
  class CardOrganization
    # Index for card array. Index 0 is face value, 1 is suit value
    FACE = 0
    SUIT = 1

    def face_values
      @hand.map { |card| card[FACE] }
    end

    def suit_values
      @hand.map { |card| card[SUIT] }
    end

    def card_vals_for_fifteens
      [].tap do |only_num_vals|
        face_values.each do |card|
          if card == "A"
            only_num_vals << 1
          elsif card.to_i == 0
            only_num_vals << 10
          else
            only_num_vals << card.to_i
          end
        end
      end
    end

    def card_vals_for_runs
      non_number_cards = {
        "A" => 1,
        "J" => 11,
        "Q" => 12,
        "K" => 13,
      }
      face_values.map do |card|
        non_number_cards.include?(card) ? non_number_cards[card] : card.to_i
      end
    end
  end
end