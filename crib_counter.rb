require './card_organization.rb'

module Cribbage
  class ShowHand < CardOrganization

    attr_accessor :hand

    def initialize(hand, crib = false)
      @hand = hand
      @crib = crib
    end

    def fifteens
      0.tap do |points_from_fifteens|
      	(2..5).each do |num_cards|
      		all_combos = card_vals_for_fifteens.combination(num_cards).to_a
          all_combos.each do |combo|
            points_from_fifteens += 2 if combo.inject(:+) == 15
          end
        end
      end
    end

    def pairs
      0.tap do |pair_points|
        all_combos = face_values.combination(2).to_a
        all_combos.each do |pair|
          pair_points += 2 if pair.first == pair.last
        end
      end
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
        return combo_length * total_runs if total_runs > 0
      end
      0
    end

    def flush
      if @crib
        suit_values.uniq.count == 1 ? 5 : 0
      else
        if suit_values[1..-2].uniq.count == 1
          suit_values.last == suit_values.first ? 5 : 4 
        else
          0
        end
      end
    end

    def nobs
      face_values[0..-2].each_with_index do |face, index|
        if face == "J"
          if suit_values[index] == suit_values.last
            return 1
          end
        end
      end
      0
    end

    def show_all_points
      puts "Fifteens Points: #{fifteens}"
      puts "    Pair Points: #{pairs}"
      puts "     Run Points: #{runs}"
      puts "   Flush Points: #{flush}"
      puts "      Nob Point: #{nobs}"
      fifteens + pairs + runs + flush + nobs
    end

  end
end

# crib_hand = Cribbage::ShowHand.new([
#   ["10", "H"],
#   ["J", "H"],
#   ["J", "H"],
#   ["Q", "H"],
#   ["K", "D"]
#   ])

# p crib_hand.card_vals_for_fifteens
 # p crib_hand.fifteens
 # p crib_hand.runs
 # p crib_hand.pairs
 # p crib_hand.all_show_points