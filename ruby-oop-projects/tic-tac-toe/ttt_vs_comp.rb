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

end