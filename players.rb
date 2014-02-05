require './card_organization.rb'

module Cribbage 
  class HumanPlayer
    attr_accessor :name, :points, :count_hand, :cant_play

    attr_reader :play_hand

    attr_writer :points

    def initialize(name)
      @name = name
      @points = 0
      @play_hand = []
      @count_hand = []
      @cant_play = false
    end

    def points=(val)
      @points = val
      raise ArgumentError.new("#{@name} wins!") if @points >= 120
    end

    def throw_away_cards
      @play_hand = []
      @count_hand = []
    end

    def put_2_in_crib
      crib_cards = []
      puts "#{@name}, enter cards into the crib, one at a time, by index."
      puts "Just enter the number of the index of the card to put in"
      until crib_cards.count == 2
        put_card_into(crib_cards)
      end
      crib_cards
    end

    def put_card_into(location)
      p @play_hand
      puts "Choose an index"
      index = gets.chomp.to_i
      if @play_hand[index].nil?
        puts "That is not a valid index"
      else
        location << @play_hand.delete_at(index)
      end
    end

    def play_card(table_total)
      puts "Choose a card to play (or press enter if you can't play)"
      p @play_hand
      card_idx = gets.chomp
      if @play_hand.empty? || card_idx == ""
        puts "GO"
        @cant_play = true
      else
        @count_hand << @play_hand.delete_at(card_idx.to_i)
        @count_hand.last
      end
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
      [].tap do |crib_cards|
        2.times { crib_cards << @play_hand.pop }
      end
    end
  end
end