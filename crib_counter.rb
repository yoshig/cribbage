class CribCounter
  attr_accessor :hand

  def initialize(hand)
    @hand = hand
    @total_points = 0
  end

  def card_nums
  	only_num_vals = []
  	@hand.each do |card|
  		if card[0] == "A"
        only_num_vals << 1
      elsif card[0].to_i == 0
        only_num_vals << 10
      else
        only_num_vals << card[0].to_i
      end
  	end

    only_num_vals
  end

  def card_values
    @hand.map { |card| card[0] }
  end

  def fifteens
  	(2..5).each do |num_cards|
  		all_combos = card_nums.combination(num_cards).to_a
      all_combos.each do |combo|
        @total_points += 2 if combo.inject(:+) == 15
      end
    end

    @total_points
  end

  def pairs
    all_combos = card_values.combination(2).to_a
    all_combos.each do |combo|
      @total_points += 2 if combo[0] == combo[1]
    end

    @total_points
  end

  def runs
    #change values to 1-13

    (3..5).each do |run_length|
      all_combos = card_values.combination(run_length).to_a
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

p crib_hand.card_nums
# p crib_hand.fifteens
# p crib_hand.all_points
p crib_hand.runs