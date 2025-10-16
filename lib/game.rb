class Game

  attr_reader :p1, :p2, :board

  def initialize
    @p1 = '➊'
    @p2 = '➋'
    @board = new_board
  end

  def new_board
    { 'f' => Array.new(7, '❍'),
      'e' => Array.new(7, '❍'),
      'd' => Array.new(7, '❍'),
      'c' => Array.new(7, '❍'),
      'b' => Array.new(7, '❍'),
      'a' => Array.new(7, '❍')}
  end

  def show_board
    p @board['a']
    p @board['b']
    p @board['c']
    p @board['d']
    p @board['e']
    p @board['f']
  end

  def verify_input(input)
    return input if input.to_i.between?(1, 7)
  end

  def is_full?(position)
    @board['a'][position] == @p1 || @board['a'][position] == @p2
  end 

  def empty_position(position)
    @board.each do |key, value|
      if value[position] != p1
        return key
        break
      end
    end
  end

end

#ng = Game.new

#ng.show_board