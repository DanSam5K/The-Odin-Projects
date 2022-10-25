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
    @grid.each { |row| puts row.join("|").prepend("|") << "|" }
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

  def win_diagonal?(mark)
    left_to_right = (0...@grid.length).all? do |i|
      @grid[i][i] == mark
    end

    right_to_left = (0...@grid.length).all? do |i|
      @grid[i][@grid.length - 1 - i] == mark
    end

    left_to_right || right_to_left
  end

  def win?(mark)
    self.win_row?(mark) || self.win_col?(mark) || self.win_diagonal?(mark)
  end

  def empty?(position)
    row, col = position
    @grid[row][col] == "_"
  end

  def legal_positions
    positions = []
    (0...@grid.length).each do |row|
      (0...@grid.length).each do |col|
        pos = [row, col]
        positions << pos if empty?(pos)
      end
    end
    positions
  end

end
