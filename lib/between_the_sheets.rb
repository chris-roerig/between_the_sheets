require "colorize"
require_relative "between_the_sheets/application_exit"
require_relative "between_the_sheets/application_help"
require_relative "between_the_sheets/ask"
require_relative "between_the_sheets/card"
require_relative "between_the_sheets/game"
require_relative "between_the_sheets/game_over"
require_relative "between_the_sheets/wager"
require_relative "between_the_sheets/version"

module BetweenTheSheets
  running = true

  loop do
    begin
      raise ApplicationExit unless running

      @game = Game.new(@jackpot || Game::STARTING_JACKPOT)
      @game.execute
    rescue GameOver
      @jackpot = @game.jackpot
      puts Game.message :game_over
      running = Ask.print("Play again? ", match: /y|n/) == "y"
    rescue ApplicationHelp
      puts Game.message :help
    rescue ApplicationExit, SystemExit, Interrupt
      puts Game.message :exit
      break
    rescue => e
      # TODO log e.message
      puts Game.message :error
      puts e.message
      break
    end
  end
end
