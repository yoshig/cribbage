require './point_generalizations.rb'

module Cribbage < GeneralPointScoring
  class ShowHand

    attr_accessor :hand

    def initialize(hand, crib = false)
      @hand = hand.map { |card| card[0] }
      @suits = hand.map { |card| card[1] }
      @crib = crib
    end

    def fifteens
      0.tap do |fifteen_points|
      	(2..5).each do |num_cards|
      		all_combos = card_vals_for_fifteens.combination(num_cards).to_a
          all_combos.each do |combo|
            fifteen_points += 2 if combo.inject(:+) == 15
          end
        end
      end
    end

    def pairs
      pair_points = 0
      all_combos = @hand.combination(2).to_a
      all_combos.each do |pair|
        pair_points += 2 if pair[0] == pair[1]
      end
      pair_points
    end

    def runs_from_sets(run_vals, n)
      combos = run_vals.combination(n).to_a
      combos.select do |set|
        set.last - set.first == n - 1 && set.uniq.count == set.count
      end.count
    end

    def runs
      run_cards = card_vals_for_runs.sort
      (3..5).to_a.reverse.each do |combo_length|
        total_runs = runs_from_sets(run_cards, combo_length)
        if total_runs > 0
          return combo_length * total_runs
        end
      end

      0
    end

    def flush
      if @crib
        @suits.uniq.count == 1 ? 5 : 0
      else
        @suits[1..-2].uniq.count == 1 ? (@suits.last == @suits.first ? 5 : 4) : 0
      end
    end

    def nobs
      @hand[0..-2].each_with_index do |card, suit|
        if card == "J"
          if @suits[suit] == @suits.last
            return 1
          end
        end
      end
      0
    end

    def all_show_points
      fifteens + pairs + runs + flush
    end

  end
end

crib_hand = CribCounter.new([
  ["10", "H"],
  ["J", "H"],
  ["J", "H"],
  ["Q", "H"],
  ["K", "D"]
  ])

# p crib_hand.card_vals_for_fifteens
# p crib_hand.fifteens
# p crib_hand.runs
# p crib_hand.pairs
# p crib_hand.all_show_points