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
    puts "#{@name}, choose the indexes of that you want to get rid of"
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
    [4,5]
  end
end