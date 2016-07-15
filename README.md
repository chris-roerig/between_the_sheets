# BetweenTheSheets

## Installation

    $ gem install between_the_sheets
    $ between_the_sheets

## Usage

```
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
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec between_the_sheets` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chris-roerig/between_the_sheets.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
