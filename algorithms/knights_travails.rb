class Knight
  attr_accessor :position, :parent, :children

  def initialize(position, parent = nil)
    @position = position
    @parent = parent
    @children = []
  end

  def to_s
    @position.to_s
  end

  def add_child(child)
    @children << child
  end

  def find_path
    path = []
    current = self
    while current
      path << current.position
      current = current.parent
    end
    path.reverse
  end
end


class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def knight_moves(start, finish)
    knight = Knight.new(start)
    queue = [knight]
    until queue.empty?
      current = queue.shift
      return current.find_path if current.position == finish
      current.children = possible_moves(current.position)
      current.children.each do |child|
        child.parent = current
        queue << child
      end
    end
  end

  def possible_moves(position)
    moves = []
    moves << [position[0] + 2, position[1] + 1]
    moves << [position[0] + 2, position[1] - 1]
    moves << [position[0] - 2, position[1] + 1]
    moves << [position[0] - 2, position[1] - 1]
    moves << [position[0] + 1, position[1] + 2]
    moves << [position[0] + 1, position[1] - 2]
    moves << [position[0] - 1, position[1] + 2]
    moves << [position[0] - 1, position[1] - 2]
    moves.select { |move| valid_move?(move) }.map { |move| Knight.new(move) }
  end

  def valid_move?(move)
    move[0].between?(0, 7) && move[1].between?(0, 7)
  end
end