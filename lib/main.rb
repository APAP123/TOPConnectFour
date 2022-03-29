#Game class
class Game
  def initialize(board = Array.new(7) { Array.new(6, ' ') })
    @board = board
  end

  # Places player's piece in passed column
  def place_piece(column, player)
    @board[column].each_with_index do |space, index|
      if space == ' '
        @board[column][index] = player
        break
      end
    end
  end

  # Checks if column is available to have a piece placed
  def valid_move?(column)
    return false if column.negative? || column > 6
    return false if @board[column][5] != ' '

    true
  end
end
