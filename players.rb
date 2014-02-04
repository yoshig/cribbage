module Cribbage 
  class HumanPlayer
    attr_accessor :name, :points, :count_hand

    attr_reader :play_hand

    def initialize(name)
      @name = name
      @points = 0

      @play_hand = []
      @count_hand = []
    end

    def throw_away_cards
      @play_hand = []
      @count_hand
    end

    def put_2_in_crib
      crib_cards = []
      puts "#{@name}, enter cards into the crib, one at a time, by index."
      puts "Just enter the number of the index of the card to put in"
      until crib_cards.count == 2
        p @play_hand
        puts "Choose an index"
        index = gets.chomp.to_i
        if @play_hand[index].nil?
          puts "That is not a valid index"
        else
          crib_cards << @play_hand.delete_at(crib_cards)
        end
      end
      crib_cards
    end
  end

  # For now, I am making the computer dumb, so I can test the game play
  # I will add AI later
  class CompPlayer
    attr_accessor :name

    attr_reader :play_hand, :count_hand, :points

    def initalize(name)
      @name = name
      @points = 0
    end

    def throw_away_cards
      @play_hand = []
      @count_hand = []
    end

    def put_2_in_crib
      []. do |crib_cards|
        2.times { crib_cards << @play_hand.pop }
      end
    end
  end
end