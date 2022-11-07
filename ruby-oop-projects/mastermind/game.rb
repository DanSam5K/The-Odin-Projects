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

