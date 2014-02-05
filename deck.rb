module Cribbage
  class Deck
    attr_accessor :face_vals, :cards
    def initialize
      @suits = ["D", "C", "H", "S"]
      @face_vals = ["A"] + ("2".."10").to_a + ["J", "Q", "K"]
      @cards = self.shuffle
    end

    def shuffle
      @cards = []
      @suits.each do |suit|
        @face_vals.each do |face_val|
          @cards << [face_val.dup, suit.dup]
        end
      end
      @cards.shuffle
    end
  end
end