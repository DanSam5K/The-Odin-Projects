require 'pry-byebug'

class Player
  attr_reader  :name, :mark

  def initialize(name, mark_value)
    @name = name
    @mark = mark_value
  end

  def get_position
    puts "#{@name}, enter two numbers representing a position in the format `row col`"
    position = gets.chomp.split(" ")
    position.map! { |ele| ele.to_i }
  end
end
