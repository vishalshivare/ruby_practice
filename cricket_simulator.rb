class Lengaburu

  attr_accessor :remaining_balls, :remaining_wickets, :striker, :non_striker, :runs_required, :players, :total_overs

  def initialize(players,runs,overs,wickets)
    @players = players
    @striker = players[0]
    @non_striker = players[1]
    @runs_required = runs
    @total_overs = overs
    @remaining_balls = 6*overs
    @remaining_wickets = wickets
    @values = Hash["one" => 1, "two" => 2,"three" => 3, "four" => 4,"five" => 5, "six" => 6,"dot" => 0]
  end

  def strike_changes
    temp = @striker
    @striker = @non_striker
    @non_striker = temp
  end

  def get_next_player
    if @players.index(@striker) < @players.index(@non_striker)
      @striker= @players[@players.index(@non_striker) + 1]
    else
      @striker= @players[@players.index(@striker) + 1]
    end
  end

  def add_runs_and_balls_for_player(run)
    index = @players.index(@striker)
    @players[index][:runs] += run
    @players[index][:balls] += 1
  end

  def get_score_on_ball(probabilities)
    max    = sum_of_probability(probabilities)
    target = rand(0..max)
    probabilities.each do |run, probability|
      return @values[run.to_s] if target <= probability
      target -= probability
    end
  end

  def sum_of_probability(probabilities)
    probabilities.inject(0) { |sum, (run, probability)| sum + probability }
  end
end

players=Array.new
players.push({ name: "Kirat Boli",
  runs: 0,
  balls: 0,
  status: "not_out",
  probability: {
    dot: 5,
    one: 30,
    two:25,
    three:10,
    four: 15,
    five: 1,
    six: 9,
    out: 5
  }
})

players.push({ name: "N.S Nodhi",
  runs: 0,
  balls: 0,
  status: "not_out",
  probability: {
    dot: 10,
    one: 40,
    two:20,
    three:5,
    four: 10,
    five: 1,
    six: 4,
    out: 10
  }
})

players.push({ name: "R Rumrah",
  runs: 0,
  balls: 0,
  status: "not_out",
  probability: {
    dot: 20,
    one: 30,
    two: 15,
    three: 5,
    four: 5,
    five: 1,
    six: 4,
    out: 20
  }
})

players.push({ name: "Shashi Herna",
  runs: 0,
  balls: 0,
  status: "not_out",
  probability: {
    dot: 30,
    one: 25,
    two: 5,
    three: 0,
    four: 5,
    five: 1,
    six: 4,
    out: 30
  }
})

lengaburu=Lengaburu.new(players,40,4,3)
overs = 0.0
balls_per_over = 0
current_over = 0
loop do
  if balls_per_over == 0
    puts "\n#{lengaburu.total_overs} overs left. #{lengaburu.runs_required} runs to win"
  end

  balls_per_over += 1
  lengaburu.remaining_balls -= 1

  score_on_ball = lengaburu.get_score_on_ball(lengaburu.striker[:probability])

  case score_on_ball
  when 1,3,5
    puts "#{overs.to_f + ((balls_per_over.to_f/10).to_f)} #{lengaburu.striker[:name]} scored #{score_on_ball} run"
    lengaburu.runs_required -= score_on_ball
    lengaburu.add_runs_and_balls_for_player(score_on_ball)
    lengaburu.strike_changes

  when 0,2,4,6
    puts "#{overs.to_f + ((balls_per_over.to_f/10).to_f)} #{lengaburu.striker[:name]} scored #{score_on_ball} run"
    lengaburu.runs_required -= score_on_ball
    lengaburu.add_runs_and_balls_for_player(score_on_ball)

  else
    puts "#{overs.to_f + ((balls_per_over.to_f/10).to_f)} #{lengaburu.striker[:name]} is out"
    lengaburu.add_runs_and_balls_for_player(0)
    lengaburu.striker[:status] = 'out'

    if(lengaburu.remaining_wickets > 0)
      lengaburu.remaining_wickets -= 1
      lengaburu.get_next_player
    end
  end

  if balls_per_over == 6
    lengaburu.strike_changes
    balls_per_over = 0
    overs += 1
    lengaburu.total_overs -= 1
  end

  if lengaburu.remaining_balls==0 || lengaburu.remaining_wickets==0
    puts "\nLengaburu lost by #{lengaburu.runs_required} runs\n"
    break
  elsif lengaburu.runs_required <= 0
    puts "\nLengaburu won by #{lengaburu.remaining_wickets} wickets and #{lengaburu.remaining_balls} balls\n"
    break
  end
end

players.each do |player|
  if player[:status] != 'out'
    puts "#{player[:name]} - #{player[:runs]}* (#{player[:balls]} balls #{})"
  else
    puts "#{player[:name]} - #{player[:runs]} (#{player[:balls]} balls #{})"
  end
end
