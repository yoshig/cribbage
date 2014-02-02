require './crib_counter.rb'

class CribbageGame
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @deck = Deck.new
    @whos_crib = []
    @p1_points = 0
    @p2_points = 0
  end

  def pick_first_crib
    p1_card = @deck.deck.pop[0]
    p2_card = @deck.pop[0]
    case @deck.face_vals.index(p1_card) <=> @deck.face_vals.index(p2_card)
    when 1
      puts "#{p2_card} is less than #{p1_card}. Player 2 starts"
      @whos_crib = [@player1, @player2]
    when -1
      puts "#{p1_card} is less than #{p2_card}. Player 1 starts"
      @whos_crib = [@player1, @player2]
    when 0
      puts "You both chose #{p1_card}"
      pick_first_crib
  end

  def full_game
    pick_first_crib

    until winner?
    end


  end

  def winner?
    if @p1_points >= 120
      puts "Player 1 wins!"
    elsif @p2_points >= 120
      puts "Player 2 wins!"
    else
      false
    end
  end
end


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

d = Deck.new
p d.cards