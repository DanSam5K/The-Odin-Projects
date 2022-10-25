require_relative './player.rb'
require_relative './board.rb'

class TicTacToe
  def initialize
    @board = Board.new
    @player1 = Player.new("Player1", "X")
    @player2 = Player.new("Player2", "O")
    @current_player = @player1
  end

  def play
    while @board.empty_positions?
      @board.print
      position = @current_player.get_position
      @board.place_mark(position, @current_player.mark)
      if @board.win?(@current_player.mark)
        puts "victory!"
        return
      else
        self.switch_turn
      end
    end
    puts "draw"
  end

  def switch_turn
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end
end
