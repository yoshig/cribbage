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
      return 0 unless total == 15
      puts "Fifteen for 2!"
      2
    end

    def thirtyone_for_two
      # I made this one since GO! is also worth 1
      return 0 unless total == 31
        puts "31 for 2!"
        1
    end

    def pairs
      4.downto(2) do |pair_num|
        if !face_values[-pair_num..-1].nil? &&
          face_values[-pair_num..-1].uniq.length == 1
          pair_points = pair_num * (pair_num - 1)
          puts "#{total} for #{pair_points}!"
          return pair_points 
        end
      end
      0
    end

    def runs
      test_runs = (3..face_values.length).to_a.reverse
      test_runs.each do |combo_length|
        next if combo_length > face_values.length
        test_combo = card_vals_for_runs[-combo_length..-1].sort
        if (test_combo.last - test_combo.first == combo_length - 1) &&
          (test_combo.uniq.count == test_combo.count)
          puts "#{total} for #{combo_length}!"
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