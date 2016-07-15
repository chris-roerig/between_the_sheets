require "digest"

module BetweenTheSheets
  class CardImage
    #🂡	🂢	🂣	🂤	🂥	🂦	🂧	🂨	🂩	🂪	🂫	🂬	🂭	🂮
    #🂱	🂲	🂳	🂴	🂵	🂶	🂷	🂸	🂹	🂺	🂻	🂼	🂽	🂾
    #🃁	🃂	🃃	🃄	🃅	🃆	🃇	🃈	🃉	🃊	🃋	🃌	🃍	🃎
    #🃑	🃒	🃓	🃔	🃕	🃖	🃗	🃘	🃙	🃚	🃛	🃜	🃝	🃞
    #🃟
    #🂠
  end

  class Card
    NAMES = %w{A 2 3 4 5 6 7 8 9 10 J Q K JOKER}.freeze
    SUITS = %w{clubs diamonds hearts spades}.freeze
    SUIT_COLORS = {
      clubs: :white,
      diamonds: :red,
      hearts: :red,
      spades: :white
    }.freeze
    IMAGES = {
      clubs: "\u2664",
      hearts: "\u2661",
      diamonds: "\u2662",
      spades: "\u2667"
    }.freeze

    attr_reader :name, :suit, :value

    def initialize
      @name = NAMES.sample
      @suit = SUITS.sample
      @image = IMAGES[@suit.to_sym]
      @value = self.class.value(@name)
    end

    def self.draw(*skip_cards)
      return Card.new if skip_cards.empty?

      loop do
        card = Card.new
        break card unless skip_cards.include? card.id
      end
    end

    def self.value(name)
      case name
      when "A"
        1
      when "J"
        11
      when "Q"
        12
      when "K"
        13
      when "JOKER"
        0
      else
        NAMES.index(name) + 1
      end
    end

    def to_s
      # The space at the end is intentional to pad the image with the
      # next character.
      "#{@name}#{@image.colorize(SUIT_COLORS[@suit.to_sym])} "
    end

    def id
      (Digest::MD5.new << self.to_s).to_s
    end

    def joker?
      @name == "JOKER"
    end
  end
end
