class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    user_input = require_sequence
    if seq.join(" ") == user_input
      round_success_message
      @sequence_length += 1
    else
      @game_over = true
    end    
  end

  def show_sequence
    add_random_color
    puts seq
    sleep(2)
    system("clear")    
  end

  def require_sequence
    print "Enter the sequence: "
    input = gets.chomp
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "you passed!"
  end

  def game_over_message
    puts "game over!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
