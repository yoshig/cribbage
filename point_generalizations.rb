module Cribbage
  class GeneralPointScoring
    def card_vals_for_fifteens
      only_num_vals = []
      @hand.each do |card|
        if card == "A"
          only_num_vals << 1
        elsif card.to_i == 0
          only_num_vals << 10
        else
          only_num_vals << card.to_i
        end
      end

      only_num_vals
    end

    def card_vals_for_runs
      non_number_cards = {
        "A" => 1,
        "J" => 11,
        "Q" => 12,
        "K" => 13,
      }
      @hand.map do |card|
        non_number_cards.include?(card) ? non_number_cards[card] : card.to_i
      end
    end
  end
end