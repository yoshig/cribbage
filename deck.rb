class Deck
  attr_accessor :face_vals, :deck
  def initialize
    @suits = ["D", "C", "H", "S"]
    @face_vals = ["A"] + ("1".."10").to_a + ["J", "Q", "K"]
    @deck = self.shuffle
  end

  def shuffle
    final_deck = []
    @suits.each do |suit|
      @face_vals.each do |face_val|
        final_deck << [face_val, suit]
      end
    end
    final_deck.shuffle
  end
end