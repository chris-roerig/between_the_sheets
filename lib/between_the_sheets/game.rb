require "between_the_sheets/game/constants"
require "between_the_sheets/game/messages"
require "between_the_sheets/game/screens"
require "between_the_sheets/game/rules/bust/consecutive"
require "between_the_sheets/game/rules/bust/joker"
require "between_the_sheets/game/rules/win/joker"
require "between_the_sheets/game/rules/win/same_cards"

module BetweenTheSheets
  class Game
    include Constants
    include Screens
    extend Messages

    attr_reader :card1, :card2, :card3, :jackpot, :play

    def initialize(jackpot = STARTING_JACKPOT)
      @rounds = 1
      @credits = STARTING_CREDITS
      @jackpot = jackpot
    end

    # Loads the first 2 cards and checks rules.
    def draw_initial_cards
      @card1 = Card.draw
      @card2 = Card.draw(@card1.id)

      # check for joker
      raise Rules::Bust::Joker if @card1.joker? || @card2.joker?

      # check for consecutive
      raise Rules::Bust::Consecutive if (@card1.value - @card2.value).abs == 1

      # player wins if the cards are the same
      raise Rules::Win::SameCards if @card1.value == @card2.value
    end

    # Loads the 3rd card and checks for rules.
    def draw_final_card
      @card3 = Card.draw(@card1.id, @card2.id)
      puts "The next card is the #{@card3}"

      # player wins if card is Joker
      raise Rules::Win::Joker if @card3.joker?
    end

    # Bool whether card 3 is between cards 1 & 2
    def is_between?
      is_between = @card3.value.between?(@card1.value, @card2.value)

      is_between && @play == "y" || !is_between && @play == "n"
    end

    # Prints the win message and increments the players credits.
    def win(credits=nil)
      @credits += credits if credits
      puts self.class.message(:win).colorize :green
    end

    # Prints the jackpot message and increments the players credits.
    def win_jackpot
      @credits += @jackpot
      @jackpot = STARTING_JACKPOT
      puts self.class.message(:jackpot).colorize :green
    end

    # Prints the lost message and decrements the players credits.
    def lose(credits=nil)
      @credits -= credits if credits
      puts self.class.message(:lose).colorize :red
    end

    # The main game loop.
    def execute
      loop do
        transition_screen if @rounds > 1

        # Show the intro screen
        intro_screen

        @rounds += 1
        @credits -= ANTE
        @jackpot += JACKPOT_ANTE

        puts "\nAfter ante you have #{@credits.to_s.colorize(:green)} credits"

        continue = begin
          draw_initial_cards
        rescue Rules::Bust::Joker
          puts "House drew a Joker "
          lose
        rescue Rules::Bust::Consecutive
          puts "House drew consecutive cards #{@card1} & #{@card2} "
          lose
        rescue Rules::Win::SameCards
          puts "House drew #{@card1} and #{@card2} "
          win_jackpot
        else
          true
        end

        next unless !!continue

        # Ask player if next card is between
        is_between_screen

        # Ask player for their wager
        wager = Wager.get(@credits, @jackpot)

        continue = begin
          draw_final_card
        rescue Rules::Win::Joker
          puts "You drew a #{@card3}"
          win wager
        else
          true
        end

        next unless !!continue

        # check the between rules
        if is_between?
          win wager
        else
          lose wager
        end
      end
    end
  end
end
