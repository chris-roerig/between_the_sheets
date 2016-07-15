module BetweenTheSheets
  class Game
    module Screens
      def intro_screen
        if @credits <= Game::ANTE
          puts "You're out of credits."
          raise GameOver
        end

        puts Game.message :banner

        puts "Round: #{@rounds} | Jackpot: #{@jackpot} | Ante: #{Game::ANTE} | Credits: #{@credits.to_s.colorize(:green)}"
      end

      def is_between_screen
          @play = Ask.print "Is the next card between #{@card1} and #{@card2}? ",
                           match: /y|n/
      end

      def transition_screen
        Ask.print "Hit enter to deal again. "
        system ( Gem.win_platform? ? "cls" : "clear" )
      end
    end
  end
end
