#Game class
class Game
  def initialize(board = Array.new(6) { Array.new(7, ' ') })
    @board = board
    @current_player = 'X'
  end

  # Places player's piece in passed column
  def place_piece(column, player)
    (0..@board.length - 1).reverse_each do |row|
      # puts "Current row column: #{[row, column]}"
      # puts "contains: #{@board[row][column]}"
      if @board[row][column] == ' '
        @board[row][column] = player
        return [row, column]
      end
    end
  end

  # Switches the current player
  def switch_players
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  # Checks if column is available to have a piece placed
  def valid_move?(column)
    return false if column.negative? || column > 6
    return false if @board[0][column] != ' '

    true
  end

  # Returns true if current player has just won the game
  def someone_win?(coords, player)
    # Since the last played piece is the one that would complete
    # a row, we only need to check the surrounding area of that
    # particular piece, rather than the state of the whole board
    #
    # Horizontal
    puts "Coords: #{coords}"
    consecutive = 0
    @board[coords[0]].each do |space|
      if space != player
        consecutive = 0
        next
      end
      consecutive += 1 if space == player
      return true if consecutive == 4
    end

    # Vertical
    consecutive = 0
    for y_pos in coords[0]-3..coords[0]+3 do
      next if y_pos.negative? || y_pos > 5

      puts "current row: #{@board[y_pos]}"

      if @board[y_pos][coords[1]] != player
        consecutive = 0
        next
      end
      consecutive += 1 if @board[y_pos][coords[1]] == player
      return true if consecutive == 4
    end

    # Diagonal "down"
    consecutive = 0
    (-3..3).each do |offset|
      y_pos = coords[0] + offset
      x_pos = coords[1] + offset
      next if y_pos.negative? || x_pos.negative? || y_pos > 5

      if @board[y_pos][x_pos] != player
        consecutive = 0
        next
      end
      consecutive += 1 if @board[y_pos][x_pos] == player
      return true if consecutive == 4
    end

    # Diagonal "up"
    consecutive = 0
    (-3..3).each do |offset|
      y_pos = coords[0] + offset
      x_pos = coords[1] + (offset * -1)
      next if y_pos.negative? || x_pos.negative? || y_pos > 5

      if @board[y_pos][x_pos] != player
        consecutive = 0
        next
      end
      consecutive += 1 if @board[y_pos][x_pos] == player
      return true if consecutive == 4
    end

    false
  end

  # Checks if the board is full
  def board_full?
    (0..@board.length - 1).each do |y|
      (0..@board[y].length - 1).each do |x|
        return false if @board[y][x] == ' '
      end
    end
    true
  end

  # Main driver of the program
  def make_move
    loop do
      print_self
      puts "Player #{@current_player}, please enter a column to place your piece in."
      until valid_move?(column = gets.chomp.to_i)
        puts 'Invalid location! Please choose a different column.'
      end
      coords = place_piece(column, @current_player)
      return "#{@current_player} wins!" if someone_win?(coords, @current_player)
      return "It's a draw!" if board_full?

      switch_players
    end
  end

  # Prints board to screen
  def print_self
    for i in 0..@board.length-1 do
      print '| '
      for j in 0..@board[i].length-1 do
        print "#{@board[i][j]} | "
      end
      puts "\n-----------------------------"
    end
    print '|'
    (0..6).each do |num|
      print " #{num} |"
    end
    puts "\n"
    # p @board
  end
end

game = Game.new

puts game.make_move
