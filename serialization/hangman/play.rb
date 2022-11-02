class Hangman
  def initialize
    @word = words.sample
    @lives = 7
    @word_teaser = ""

    @word.first.size.times do
      @word_teaser += "_ "
    end
  end

  def words
    [
      ["cricket", "A game played by two gentlemen"],
      ["jogging", "We are not walking..."],
      ["celebrate", "Remembering special moments"],
      ["continent", "There are 7 of these"],
      ["exotic", "Not from around here..."],
    ]
  end

  def print_teaser(last_guess = nil)
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser(last_guess)
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      if letter == '_' && @word.first[index] == last_guess
        new_teaser[index] = last_guess
      end
    end

    @word_teaser = new_teaser.join(' ')
  end

  def make_guess
    if @lives > 0
      puts "Enter a letter"
      guess = gets.chomp

      good_guess = @word.first.include? guess
      if guess == "exit"
        puts "Thank you for playing!"
      elsif good_guess
        puts "You are correct!"

        print_teaser(guess)
        if @word.first == @word_teaser.split.join
          puts "Congratulations! You won!"
        else
          make_guess
        end
      else
        @lives -= 1
        puts "Incorrect guess ... you have #{@lives} lives left Try again!"
        puts make_guess
      end
    else
      puts "Game over!... better luck next time"
    end
  end


  def begin
    puts "New game started... your clue is: #{ @word.first.size } letters long"
    puts "To exit the game at any time, type 'exit'"
    print_teaser

    puts "your clue is: #{ @word.last }"
    make_guess
  end

end

game = Hangman.new

game.begin