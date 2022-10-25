module TicTacToe
  LINES = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

  class Game
    
    attr_reader :board, :current_player_id
    def initialize(player_1_class, player_2_class)
      @board = Array.new(10)

      @current_player_id = 0
      @players = [player_1_class.new(self, "X"), player_2_class.new(self, "O")]

      puts "#{current_player} goes first."
    end

    def play
      loop do
        place_player_marker(current_player)

        if player_has_won?(current_player)
          puts "#{current_player} wins!"
          print_board
          return
        elsif board_full?
          puts "It's a draw!"
          print_board
          return
        end

        switch_players!
      end
    end
    
    def free_positions
      (1..9).select { |position| @board[position].nil? }
    end

    def place_player_marker(player)
      position = player.select_position!
      puts "#{player} selects #{player.marker} position #{position}"

      @board[position] = player.marker
    end
    

    def player_has_won?(player)
      LINES.any? do |line|
        line.all? { |position| @board[position] == player.marker }
      end
    end

    def board_full?
      free_positions.empty?
    end

    def switch_players!
      @current_player_id = (@current_player_id + 1) % 2
    end

    def other_player_id
      1 - @current_player_id
    end

    def current_player
      @players[@current_player_id]
    end

    def opponent
      @players[other_player_id]
    end

    def turn_num
      10 - free_positions.size
    end

    def print_board
      col_separator, row_separator = "|", "---+---+---"
      label_for_position = ->(position) { @board[position] || position }

      row_for_display = ->(row) do
        row.map(&label_for_position).join(col_separator)
      end
      row_positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
      rows_for_display = row_positions.map(&row_for_display)

      puts rows_for_display.join("\n" + row_separator + "\n")
    end
  end
  

  class Player

    attr_reader :marker

    def initialize(game, marker)
      @game = game
      @marker = marker
    end
  end

  class HumanPlayer < Player
    def select_position!
      @game.print_board
      loop do
        print "Select your #{marker}: "
        selection = gets.to_i
        return selection if @game.free_positions.include?(selection)
        puts "Position #{selection} is not available. Try again."
      end
    end

    def to_s
      "Human"
    end
  end

  class ComputerPlayer < Player
    DEBUG = false

    def group_positions_by_markers(line)
      markers = line.group_by { |position| @game.board[position] }
      markers.default = []
      markers
    end

    def select_position!
      opponent_marker = @game.opponent.marker
      winining_or_blocking_position = look_for_winning_or_blocking_position(opponent_marker)
      return winining_or_blocking_position if winining_or_blocking_position

      if corner_trap_defense_needed?
        return corner_trap_defense_position(opponent_marker)
      end

      return random_prioritized_position
    end

    def look_for_winning_or_blocking_position(opponent_marker)
      for line in LINES
        markers = group_positions_by_markers(line)
        next if markers[nil].size != 1
        if markers[self.marker].size == 2
          log_debug("Winning on line #{line.join}")
          return markers[nil].first
        elsif markers[opponent_marker].size == 2
          log_debug("could Block on line #{line.join}")
          blocking_position = markers[nil].first
        end
      end
      if blocking_position
        log_debug("Blocking at #{blocking_position}")
        return blocking_position
      end
    end

    def corner_trap_defense_needed?
      corner_positions = [1, 3, 7, 9]
      opponent_choose_a_corner = corner_positions.any? {|pos| @game.board[pos] != nil }
      return @game.turn_num == 2 && opponent_choose_a_corner
    end

    def corner_trap_defense_position(opponent_marker)
      log_debug "defending against corner start by playing adjacent position"
      opponent_position = @game.board.find_index { |marker| marker == opponent_marker }

      safe_responses = {1 => [2,4], 3 => [2,6], 7 => [4,8], 9 => [6,8]}
      return safe_responses[opponent_position].sample
    end

    def random_prioritized_position
      log_debug "picking random position, favouring center amd then corners"
      ([5] + [1, 3, 7, 9].shuffle + [2, 4, 6, 8].shuffle).find do |position|
        @game.free_positions.include?(position)
      end
    end

    def log_debug(messages)
      puts "#{self} #{messages}" if DEBUG
    end

    def to_s
      "Computer #{@game.current_player_id}"
    end

  end

end

include TicTacToe
Game.new(ComputerPlayer, ComputerPlayer).play

puts 

players_with_human = [HumanPlayer, ComputerPlayer].shuffle

Game.new(*players_with_human).play