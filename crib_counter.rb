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
      "A" => 1
      "J" => 11
      "Q" => 12
      "K" => 13
    }
    @hand.map do |card|
      non_number_cards.include?[card[0]]
    end
  end

  def fifteens
  	(2..5).each do |num_cards|
  		all_combos = card_vals_for_fifteens.combination(num_cards).to_a
      all_combos.each do |combo|
        @total_points += 2 if combo.inject(:+) == 15
      end
    end

    @total_points
  end

  def pairs
    all_combos = @hand.combination(2).to_a
    all_combos.each do |combo|
      @total_points += 2 if combo[0] == combo[1]
    end

    @total_points
  end

  def runs
    #change values to 1-13

    (3..5).each do |run_length|
      all_combos = @hand.combination(run_length).to_a
      all_combos.map! { |a| a.sort }
      p all_combos
    end
  end

  def all_points
    fifteens
    pairs
  end

end

crib_hand = CribCounter.new([
  ["3", "H"],
  ["2", "H"],
  ["K", "S"],
  ["K", "D"],
  ["K", "C"]
  ])

p crib_hand.card_vals_for_fifteens
# p crib_hand.fifteens
# p crib_hand.all_points
p crib_hand.runs