def randomize(array)
  4.times do
    array.push(rand(1..6))
  end
end

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end

class Guesser
  attr_reader :gameover
  def initialize(guesses, guess_length)
    @guesses = guesses
    @guess_length = guess_length
    @current_guess = []
    @correct_guess = Array.new(guess_length)
    @gameover = false
    @num_correct = 0
    @num_almost_correct = 0
  end

  def set_guess
    puts "\nGuess the code. You have #{@guesses} guesses." 