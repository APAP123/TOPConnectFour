#Game class
class Game
  def initialize( board = Array.new(7) { Array.new(7, ' ') })
    @board = board
  end

  def valid_move?(column)
    return false if column.negative? || column > 6
    return false if @board[column][0] != ' '

    true
  end
end
