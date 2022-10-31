module GameLogic
  def compare(master, guess)
    temp_master = master.clone
    temp_guess = guess.clone
    @exact_number = exact_match(temp_master, temp_guess)
    @near_number = near_match(tem_master, tem_guess)
    @total_number = exact_number + near_number
  end

  def exact_match(master, guess)
    exact_match = 0
    master.each_with_index do |color, index|
      if color == guess[index]
        exact_match += 1
        master[index] = nil
        guess[index] = nil
      end
    end
    exact_match
  end

  def near_match(master, guess)
    near = 0
    guess.each_index do |index|
      next unless guess[index] != nil && master.include?(guess[index])

      near += 1
      remove = master.find_index(guess[index])
      master[remove] = "?"
      guess[index] = "?"
    end
    near
  end

  def solved?(master, guess)
    master == guess
  end

  def  repeat_game
    puts game_message('repeat_prompt')
    replay = gets.chomp
    puts game_message('thanks') if replay.downcase != 'y'
    Game.new.play if replay.downcase == 'y'
  end 
end