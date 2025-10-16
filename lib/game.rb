class Game

  attr_reader :p1, :p2, :board

  def initialize
    @p1 = '➊'
    @p2 = '➋'
    @board = new_board
    @current_player = @p1
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
    puts "\n  1  2  3  4  5  6  7"
    @board.keys.reverse.each do |row|
      puts "#{row} " + @board[row].join('  ')
    end
    puts
  end

  def verify_input(input)
    input.to_i.between?(1, 7)
  end

  def column_full?(column)
    @board['f'][column] != '❍'
  end

  def lowest_empty_row(column)
    @board.keys.each do |row|
      return row if @board[row][column] == '❍'
    end
    nil
  end

  def drop_disc(column)
    row = lowest_empty_row(column)
    if row.nil?
      puts "❌ Column full! Choose another."
      return false
    end
    @board[row][column] = @current_player
    true
  end

  def switch_player
    @current_player = (@current_player == @p1) ? @p2 : @p1
  end

  

end

#ng = Game.new

#ng.show_board