class CribCounter
  attr_accessor :hand

  def initialize(hand)
    @hand = hand.map { |card| card[0] }
    @suits = hand.map { |card| card[1] }
    @total_points = 0
  end

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
    0.tap do |pairs|
      all_combos = @hand.combination(2).to_a
      all_combos.each do |combo|
        pairs += 2 if combo[0] == combo[1]
      end
    end
  end

  def runs_from_sets(run_vals, n)
    combos = run_vals.combination(n).to_a
    combos.select do |set|
      set.last - set.first == n - 1
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

  end

  def all_points
    fifteens + pairs + runs
  end

end

crib_hand = CribCounter.new([
  ["10", "H"],
  ["J", "H"],
  ["J", "S"],
  ["Q", "D"],
  ["K", "C"]
  ])

# p crib_hand.card_vals_for_fifteens
# p crib_hand.fifteens
# p crib_hand.all_points
p crib_hand.runs