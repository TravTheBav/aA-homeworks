class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) {Array.new(0)}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, idx|
      if (0..5).include?(idx) || (7..12).include?(idx)
        4.times { cup << :stone }
      end
    end
  end

  def valid_move?(start_pos)
    valid_cups = (0..12).to_a - [6] # excludes the store cups 6 and 13 from being picked
    if valid_cups.include?(start_pos) == false
      raise "Invalid starting cup"
    elsif @cups[start_pos].empty?
      raise "Starting cup is empty"
    end
    true
  end

  def make_move(start_pos, current_player_name)
    if current_player_name == @name1
      opponent_store_idx = 13
    else
      opponent_store_idx = 6
    end
    
    starting_cup = @cups[start_pos]
    next_pos = start_pos # next position starts at the start_pos but will be incremented each time around the until loop 
    until starting_cup.empty?
      next_pos = (next_pos + 1) % 14 # uses modulo to wrap position around indexes 0 - 13
      @cups[next_pos] << starting_cup.pop unless next_pos == opponent_store_idx      
    end
    render
    next_turn(next_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13 # player takes another turn if last cup was a store cup
      return :prompt  
    elsif @cups[ending_cup_idx].length == 1 # cup was previously empty if it only has 1 stone so we switch turns
      return :switch
    else
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    if @cups[0..5].all? { |cup| cup.empty? }
      return true
    elsif @cups[7..12].all? { |cup| cup.empty? }
      return true
    else
      return false
    end
  end

  def winner
    if @cups[6].length == @cups[13].length
      return :draw
    elsif @cups[6].length > @cups[13].length
      return @name1
    else
      return @name2
    end
  end
end
