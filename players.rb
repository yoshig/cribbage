class HumanPlayer
  attr_accessor :name

  attr_reader :hand, :points

  def initialize(name)
    @name = name
    @points = 0
  end

  def throw_away_cards
    @hand = []
  end

  def put_2_in_crib
    crib_cards = []
    puts "#{@name}, enter cards into the crib, one at a time, by index."
    puts "Just enter the number of the index of the card to put in"
    until crib_cards.count == 2
      p @hand
      puts "Choose an index"
      index = gets.chomp.to_i
      if @hand[index].nil?
        puts "That is not a valid index"
      else
        crib_cards << @hand.delete_at(crib_cards)
      end
    end
    crib_cards
  end
end

# For now, I am making the computer dumb, so I can test the game play
# I will add AI later
class CompPlayer
  attr_accessor :name

  attr_reader :hand, :points

  def initalize(name)
    @name = name
    @points = 0
  end

  def throw_away_cards
    @hand = []
  end

  def put_2_in_crib
    []. do |crib_cards|
      2.times { crib_cards << @hand.pop }
    end
  end
end