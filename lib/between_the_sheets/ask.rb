module BetweenTheSheets
  class Ask
    def self.print(output = "", options = {})
      $stdout.print output
      prompt(options)
    end

    def self.puts(output = "", options = {})
      $stdout.puts output
      prompt(options)
    end

    def self.prompt(options = {})
      options = { to_int: false, match: nil }.merge(options)
      match = options[:match]

      input = gets.chomp.downcase
      raise ApplicationExit if input.match(/^q|quit|^e|exit/)
      raise ApplicationHelp if input.match(/^h|help/)

      if match && input.match(match).to_s.empty?
        input = loop do
          try = self.print("Invalid response. Choices are: " + match.to_s.gsub("?-mix:", "") + " ")
          break try if try.match(match)
        end
      end

      if options[:to_int]
        input.gsub(/\D/, "").to_i
      else
        input
      end
    end
  end
end
