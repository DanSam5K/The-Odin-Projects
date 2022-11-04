require 'open-uri'

class Hangman
  def initialize
    @word = words.sample
    @lives = 7
    @word_teaser = ""

    @word.size.times do
      @word_teaser += "_ "
    end
  end

  def download_google_words
    url = "https://raw.githubusercontent.com/dwyl/english-words/master/words.txt"

    words_file = URI.open(url).read
    words_file_array = words_file.split("\n")

    words_file_array
  end

  def words
    words = download_google_words
  end

  def print_teaser(last_guess = nil)
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser(last_guess)
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      if letter == '_' && @word[index] == last_guess
        new_teaser[index] = last_guess
      end
    end

    @word_teaser = new_teaser.join(' ')
  end

  def make_guess
    if @lives > 0
      puts "Enter a letter"
      guess = gets.chomp

      good_guess = @word.include? guess
      if guess == "exit"
        puts "Thank you for playing!"
      elsif good_guess
        puts "You are correct!"

        print_teaser(guess)
        if @word == @word_teaser.split.join
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
    puts "New game started... your clue is: #{ @word.size } letters long"
    puts "To exit the game at any time, type 'exit'"
    print_teaser

    puts "your clue is: #{ @word[0] }"
    make_guess
  end

end

game = Hangman.new

game.begin