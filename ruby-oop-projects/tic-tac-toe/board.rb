require "pry-byebug"
class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, "_") }
  end

  def valid?(position)
    # position.is_a?(Array) && position.length == 2 && position.all? { |ele| ele.between?(0, 2) 
    row, col = position
    return false if !row.between?(0, 2) || !col.between?(0, 2)
    return false if @grid[row][col] != "_"
    true
  end

  def empty_positions?
    @grid.flatten.include?("_")
  end

  def place_mark(position, mark)
    if self.valid?(position)
      row, col = position
      @grid[row][col] = mark
    else
      raise "invalid position"
    end
  end

  def print
    @grid.each { |row| puts row.row.join("|").prepend("|") << "|" }
  end

  def win_row?(mark)
    @grid.any? do |row|
      row.all? { |ele| ele == mark }
    end
  end

  def win_col?(mark)
    @grid.transpose.any? do |col|
      col.all? { |ele| ele == mark }
    end
  end

end

board = Board.new
puts board.valid?([0,4])