def play
  @guesses = 0
  @answers = 4.times.map {"123456"chars.sample}.join
  @possible_scores = @all_scores.dup
  @possible_answers = @all_answers.dup 

  while @guesses < 10
    @guess = make_guess
    if @all_answers.include?(@guess)
      @guesses += 1
      @score = calculate_score(@guess, @answers)
      if @score == "BBBB"
        p [@guesses, @guess]
        break
      end
    end
  end
end

def calculate_score(guess, answer)
  score = ""
  wrong_guess_pegs, wrong_answer_pegs = [], []
  pegs_pairs = guess.chars.zip(answer.chars)

  peg_pairs.each do |guess_peg, answer_peg|
    if guess_peg == answer_peg
      score << "B"
    else
      wrong_guess_pegs << guess_peg
      wrong_answer_pegs << answer_peg
    end
  end

  wrong_guess_pegs.each do |guess_peg|
    if wrong_answer_pegs.include?(guess_peg)
      wrong_answer_pegs.delete_at(wrong_answer_pegs.index(guess_peg))
      score << "W"
    end
  end

  score
end

def make_guess
  if @guesses > 0
    puts "Score: #{@score}"
  else
    puts "Guess the code. You have 10 guesses."
  end

  puts "Guesses Remaining: #{10 - @guesses}"
  print "Guess: "
  gets.chomp
end

play