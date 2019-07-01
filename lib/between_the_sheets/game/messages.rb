module BetweenTheSheets
  class Game
    module Messages
      MESSAGES = {
        error: "\nSorry, there was an error.".colorize(:orange),
        exit: "\nGood bye.",
        game_over: "GAME OVER".colorize(:red),
        lose: "You LOSE!".colorize(:red),
        win: "You WIN!".colorize(:green),
        jackpot: "JACKPOT!".colorize(:green),
        banner: "\n\n          \u2664 \u2661  BETWEEN THE SHEETS \u2662 \u2667\n\n"
      }.freeze

      def message(name)
        MESSAGES.fetch(name) { help }
      end

      def help
        <<-TXT

        KEY COMMANDS:

        e or q at any prompt will quit the game.
        h or help prints the message.

        GAME RULES:

        The dealer draws 2 cards and places them face up. Next, the player may
        bet up to the entire pot or any portion of the number of chips in the
        pot, but he must always bet a minimum of #{Game::Constants::MINIMUM_BET}
        chip. When the player has placed a bet, the dealer turns up the top card
        from the pack and places it between the two cards already face up.
        If the card ranks between the two cards already face up, the player
        wins and takes back the amount of his bet plus an equivalent amount
        from the pot. If the third card is not between the face-up cards, or
        is of the same rank as either of them, the player loses his bet, and
        it is added to the pot. If the two face-up cards up are consecutive,
        the player automatically loses, and a third card need not be turned up.
        If the two face-up cards are the same, the player wins two chips and,
        again, no third card is turned up.

        "Acey-Deucey" (ace, 2) is the best combination, and a player tends to
        bet the whole pot, if he can. This is because the only way an
        ace-deuce combination can lose is if the third card turned up is also
        an ace or a deuce.

        Game rules taken and slightly modified from:
        http://www.bicyclecards.com/how-to-play/in-between/#sthash.aJuEouh8.dpuf

        TXT
      end
    end
  end
end
