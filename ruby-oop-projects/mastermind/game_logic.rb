module Rules
  COLOURS = %w[red blue green yellow orange purple].freeze
  GUESS_SPACE = [' ', ' ', ' ', ' '].freeze
  HINT_SPACE = [' ', ' ', ' ', ' '].freeze
  GAMEBOARD = [[GUESS_SPACE], [HINT_SPACE]]freeze

  # def legal_guess?(guess)
  #   guess.length == 4 && guess.all? { |colour| COLOURS.include?(colour) }
  # end

  def legal_guess?(guess)
    if guess.length != 4
      puts 'Your guess must be 4 colours long'
      return false
    elsif guess.any? { |colour| !COLOURS.include?(colour) }
      puts 'Your guess must be a valid colour'
      return false
    else
      return true
    end
  end
end

module Swaszek
  def read_guess(guess)
    perfects = board.gameboard[1][turn - 2][0].length if turn > 1
    exits = board.gameboard[1][turn - 2][1].length if turn > 1
  end
end