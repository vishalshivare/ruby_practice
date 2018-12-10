class Program
    def initialize(arguments)
      if arguments.length!=2
        puts "Please enter correct number of arguments"
        exit
      end
      @weather = arguments[0].downcase
      @match_time = arguments[1].downcase
    end

    def match_details
      case @weather
      when "cloudy"
        if @match_time == "day"
          "Lengaburu wins toss and bats"
        elsif @match_time == "night"
          "Lengaburu wins toss and bowls"
        else
          "Match is not possible."
        end

      when "clear"
        if @match_time == "day"
          "Lengaburu wins toss and bats"
        elsif @match_time == "night"
          "Lengaburu wins toss and bats"
        else
          "Match is not possible."
        end
      else
        "Match is not possible."
      end
    end
end

pgm = Program.new(ARGV)
puts pgm.match_details
