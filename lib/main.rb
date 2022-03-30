#Game class
class Game
  def initialize(board = Array.new(7) { Array.new(6, ' ') })
    @board = board
    @current_player = 'X'
  end

  # Places player's piece in passed column
  def place_piece(column, player)
    @board[column].each_with_index do |space, index|
      if space == ' '
        @board[column][index] = player
        return [column, index] # coordinates where the played-piece landed
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
    return false if @board[column][5] != ' '

    true
  end

  # Returns true if current player has just won the game
  def someone_win?(coords, player)
    # Since the last played piece is the one that would complete
    # a row, we only need to check the surrounding area of that
    # particular piece, rather than the state of the whole board
    #
    # Horizontal
    # print_self
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

  # Prints board to screen
  def print_self
    for i in 0..@board.length-1 do
      print '| '
      for j in 0..@board[i].length-1 do
        print "#{@board[i][j]} | "
      end
      puts "\n-----------------------------"
    end
    # p @board
  end
end
