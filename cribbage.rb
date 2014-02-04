require './crib_counter.rb'
require './deck.rb'
require './players.rb'
require './play_points.rb'

module Cribbage
  class Game
    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
      @deck = Deck.new
      @whos_crib = []
    end

    def players
      [@player1, @player2]
    end

    def pick_first_crib
      p1_card, p2_card = players.map { @deck.deck.pop[0] }
      puts "Player 1 chose #{p1_card}. Player 2 chose #{p2_card}."

      case @deck.face_vals.index(p1_card) <=> @deck.face_vals.index(p2_card)
      when 1
        puts "#{p2_card} is less than #{p1_card}. Player 2 starts."
        @whos_crib = [@player1, @player2]
      when -1
        puts "#{p1_card} is less than #{p2_card}. Player 1 starts."
        @whos_crib = [@player1, @player2]
      when 0
        puts "You both chose #{p1_card}. Choose again"
        pick_first_crib
      end
    end

    def full_game
      #Use catch and throw to break out if player wins?
      pick_first_crib

      full_turn

    end

    def full_turn
      deal_cards
      play_phase
      show_phase
      players.each do { |player| player.throw_away_cards }
      @whose_crib.rotate!
    end

    def deal_cards
      @deck.shuffle
      6.times do
        players.each { |player| player.play_hand << @deck.deck.pop }
      end
    end

    def add_to_crib
      puts "It is #{@whos_crib[0].name}'s crib."
      @crib = []
      players.each { |player| @crib << player.put_2_in_crib }
      @crib.flatten(1)
    end

    def communal_card
      @communal_card = @deck.deck.pop
      puts "#{@whos_crib} flipped a #{communal_card}"
      @whos_crib[0].points += 1 if communal_card[0] == "J"
    end

    def play_phase
      table_count = 0
      count_goal
      until players.all? { |player| player.play_hand.empty? }

      end
    end

    def show_phase
      @whos_crib[1].points += show_points(@whos_crib[1])
      @whos_crib[0].points += show_points(@whos_crib[0])
      @whos_crib[0].points += show_points(@crib, true)
    end

    def show_points(player, crib = false)
      show_hand = ShowHand.new(player.count_hand + [@communal_card], crib)
      show_hand.show_all_points
    end

    def winner?
      if @player1.points >= 120
        puts "Player 1 wins!"
        true
      elsif @player2.points >= 120
        puts "Player 2 wins!"
        true
      else
        false
      end
    end
  end
end

x = Game.new("Yo", "G")
x.pick_first_crib