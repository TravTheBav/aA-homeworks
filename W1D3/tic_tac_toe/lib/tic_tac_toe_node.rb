require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    case evaluator
    when :x
      opponent = :o
    else
      opponent = :x
    end

    if board.over?
      return true if board.winner == opponent
      return false if board.winner == evaluator || board.winner == nil
    end

    if next_mover_mark == evaluator # current node is on player so all children will be player nodes
      children.all? { |child_node| child_node.losing_node?(evaluator) } # check if all nodes are children nodes are losing nodes on player turn
    else # current node is on opponent so all children will be opponent nodes
      children.any? { |child_node| child_node.losing_node?(evaluator) } # check if at least one node is a losing node on opponent turn
    end
  end

  def winning_node?(evaluator)
    case evaluator
    when :x
      opponent = :o
    else
      opponent = :x
    end

    if board.over?
      return true if board.winner == evaluator
      return false if board.winner == opponent || board.winner == nil
    end

    if next_mover_mark == evaluator
      children.any? { |child_node| child_node.winning_node?(evaluator) }
    else
      children.all? { |child_node| child_node.winning_node?(evaluator) }
    end
  end

  # A helper method for #children; returns all empty positions on the
  # current board
  def get_empty_positions
    empty_positions = []
    board.rows.each_with_index do |row, x|
      row.each_with_index do |mark, y|
        empty_positions << [x,y] if board.empty?([x,y])
      end
    end
    empty_positions
  end

  # flips the current player marker
  def switch_mark
    if next_mover_mark == :x
      return :o
    else
      return :x
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_positions = get_empty_positions
    moves = []
    empty_positions.each do |pos|
      duped_board = board.dup
      duped_board[pos] = next_mover_mark
      moves << TicTacToeNode.new(duped_board, switch_mark, pos)
    end
    moves
  end
end
