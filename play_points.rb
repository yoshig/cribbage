module Cribbage
  class PlayPoints < GeneralPointScoring

    def initialize
      @hand = []
    end

    def fifteens
      2 if card_vals_for_fifteens.inject(:+) == 15
    end

    def pairs
      
      return 12 if @hand[0..3].uniq == 1 && @hand.length >= 4
      return 6  if @hand[0..2].uniq == 1 && @hand.length >= 3
      return 2  if @hand[0..1].uniq == 1 && @hand.length >= 2
      0
    end

    def runs
      test_runs = (3...@hand.length).to_a.reverse
      test_runs.each do |combo_length|
        next if combo_length > @hand.length
        test_combo = card_vals_for_runs.[0..combo_length].sort
        if test_combo.last - test_combo.first == combo_length - 1 &&
          test_combo.uniq.count == test_combo.count
          return combo_length
        end
      end
      0
    end

    def total
      @hand.inject(:+)
    end

    def reset
      @hand = []
    end
  end
end