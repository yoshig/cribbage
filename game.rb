require_relative './crib_counter.rb'
require './deck.rb'
require './players.rb'
require './card_organization.rb'
require './play_points.rb'

module Cribbage
  class Game
    
    attr_accessor :whos_crib

    attr_reader :says

    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
      @deck = Deck.new
      @whos_crib = []
    end

    def players
      [@player1, @player2]
    end

    def full_game
      pick_first_crib

      begin
        full_turn
        if players.all? { |player| player.points < 120 }
          raise ArgumentError.new("SCORE: #{@player1.points} to #{@player2.points}")
        end
      rescue Exception => e
        puts e.message
      retry if players.all? { |player| player.points < 120 }
      end
    end

    def pick_first_crib
      p1_card, p2_card = players.map { @deck.cards.pop[0] }
      puts "#{@player1.name} chose a #{p1_card}, #{@player2.name} chose a #{p2_card}."
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

    def full_turn
      deal_cards
      add_to_crib
      pick_communal_card
      play_phase
      show_phase
      players.each { |player| player.throw_away_cards }
      whos_crib.rotate!
    end

    def deal_cards
      @deck.shuffle
      6.times do
        players.each { |player| player.play_hand << @deck.cards.pop }
      end
    end

    def add_to_crib
      puts "It is #{@whos_crib[0].name}'s crib."
      @crib = []
      players.each { |player| @crib += player.put_2_in_crib }
      @crib.flatten(1)
    end

    def pick_communal_card
      @communal_card = @deck.cards.pop
      puts "#{@whos_crib[0].name} flipped a #{@communal_card}"
      if @communal_card[0] == "J"
        puts "#{@whos_crib[0]} gets 1!"
        whos_crib[0].points += 1 
      end
    end

    def play_phase
      table_cards = PlayPoints.new
      last_to_play = ""
      whos_turn = @whos_crib[0]

      until players.all? { |player| player.play_hand.empty? }
        puts "Current Table: #{table_cards.hand}"
        puts "Table total: #{table_cards.total || 0}"
        next_card = whos_turn.play_card(table_cards.total)
        unless whos_turn.cant_play
          table_cards.hand << next_card
          whos_turn.points += table_cards.add_any_points 
          last_to_play = whos_turn
        end

        if players.all? { |player| player.cant_play }
          last_to_play.points += 1
          table_cards.reset
          players.each { |player| player.cant_play = false }
        end

        whos_turn = (whos_turn == @player1 ? @player2 : @player1)
      end
    end

    def show_phase
      whos_crib[1].points += show_points(whos_crib[1].count_hand)
      whos_crib[0].points += show_points(whos_crib[0].count_hand)
      whos_crib[0].points += show_points(@crib, true)
    end

    def show_points(player, crib = false)
      show_hand = ShowHand.new(player + [@communal_card], crib)
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

yo = Cribbage::HumanPlayer.new("Player1")
g =  Cribbage::HumanPlayer.new("Player2")
x = Cribbage::Game.new(yo, g)

x.full_game