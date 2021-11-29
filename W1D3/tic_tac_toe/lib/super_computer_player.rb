require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    case mark
    when mark == :x
      opponent = :o
    else
      opponent = :x
    end

    root_node = TicTacToeNode.new(game.board, mark)
    root_node.children.each do |child_node|
      if child_node.winning_node?(mark)
        return child_node.prev_move_pos
      end
    end
    # select from non-losing nodes if there are no winning nodes
    not_losers = root_node.children.select { |child_node| !child_node.losing_node?(mark) }
    raise "There should never be losing nodes" if not_losers.empty?
    not_losers.sample.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
