module BetweenTheSheets
  class Wager
    def self.get(credits, pot)
      loop do
        input = Ask.print "What's your wager? ", to_int: true

        if input > pot
          puts "Invalid amount. You can't bet more than the pot (#{pot})"
          next
        end

        break input if input > 0 && input <= credits
        puts "Invalid amount. You have #{credits} credits."
      end
    end
  end
end
