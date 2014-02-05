 module Cribbage
  class PlayPoints < CardOrganization

    attr_accessor :hand

    def initialize
      @hand = []
    end

    def total
      card_vals_for_fifteens.inject(:+)
    end

    def fifteens
      total == 15 ? 2 : 0
    end

    def thirtyone_for_two
      # I made this one since GO! is also worth 1
      total == 31 ? 1 : 0

    end

    def pairs
      4.downto(2) do |pair_num|
        if face_values[0...pair_num].uniq == 1 && face_values.length >= pair_num
          return pair_num * (pair_num - 1) 
        end
      end
      0
    end

    def runs
      test_runs = (3...face_values.length).to_a.reverse
      test_runs.each do |combo_length|
        next if combo_length > face_values.length
        test_combo = card_vals_for_runs[0..combo_length].sort
        if (test_combo.last - test_combo.first == combo_length - 1) &&
          (test_combo.uniq.count == test_combo.count)
          return combo_length
        end
      end
      0
    end

    def add_any_points
      fifteens + pairs + runs + thirtyone_for_two
    end

    def reset
      @hand = []
    end
  end
end