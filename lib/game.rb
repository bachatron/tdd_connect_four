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
      'a' => Array.new(7, '❍') }
  end

  def show_board
    puts "\n  1  2  3  4  5  6  7"
    @board.keys.each do |row|
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
    @board.keys.reverse.each do |row|
      return row if @board[row][column] == '❍'
    end
    nil
  end

  def drop_disc(column)
    row = lowest_empty_row(column)
    puts row
    if row.nil?
      puts '❌ Column full! Choose another.'
      return false
    end
    @board[row][column] = @current_player
    true
  end

  def switch_player
    @current_player = @current_player == @p1 ? @p2 : @p1
  end

  def winner?
    board_array = @board.values.reverse

    # Horizontal check
    board_array.each do |row|
      return true if row.join.include?(@current_player * 4)
    end

    # Vertical check
    7.times do |col|
      column_str = board_array.map { |r| r[col] }.join
      return true if column_str.include?(@current_player * 4)
    end

    false
  end

  def play
    loop do
      show_board
      puts "Turn: #{@current_player} → Choose column (1–7)"
      input = gets.chomp

      unless verify_input(input)
        puts '❌ Invalid column. Try again.'
        next
      end

      column = input.to_i - 1
      next if column_full?(column)

      next unless drop_disc(column)

      if winner?
        show_board
        puts "🎉 Player #{@current_player} wins!"
        break
      end
      switch_player
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  new_game = Game.new
  new_game.play
end
