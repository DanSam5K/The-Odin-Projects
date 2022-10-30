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

  
end