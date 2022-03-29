#spec/main_spec.rb
require './lib/main'

describe Game do
  describe '#valid_move?' do
    context 'When column selection is valid' do
      it 'returns true when column is not full' do
        game = Game.new
        chosen_column = 3
        result = game.valid_move?(chosen_column)
        expect(result).to be true
      end

      it 'returns false when column is full' do
        game = Game.new(Array.new(7) { Array.new(6, 'X') })
        chosen_column = 1
        result = game.valid_move?(chosen_column)
        expect(result).to be false
      end
    end
  end

  describe '#place_piece' do
    subject(:game) { described_class.new }
    context 'When placing piece on empty column' do
      it 'Lands at the bottom of the column (position 0)' do
        chosen_column = 3
        game.place_piece(chosen_column, 'X')
        board = game.instance_variable_get(:@board)
        bottom = board[chosen_column][0]
        expect(bottom).to eq('X')
      end
    end

    context 'When placing piece on column with 3 pieces already placed' do
      it 'Lands two spaces from the top (position 3)' do
        chosen_column = 3
        game = described_class.new(Array.new(7) { ['X', 'X', 'X', ' ', ' ', ' '] })
        game.place_piece(chosen_column, 'X')
        board = game.instance_variable_get(:@board)
        middle = board[chosen_column][3]
        expect(middle).to eq('X')
      end
    end
  end

  describe '#someone_win?' do
    subject(:game) { described_class.new }
    context 'When no one has won yet' do
      it 'returns false when the board is empty' do
        player = 'X'
        coords = [5, 2]
        result = game.someone_win?(coords, player)
        expect(result).to be false
      end
      it 'returns false when the board is populated but no piece has four touching' do
        game = described_class.new(
          [
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            ['O', ' ', ' ', ' ', ' ', ' ', ' '],
            ['X', ' ', ' ', ' ', ' ', ' ', ' '],
            ['X', ' ', ' ', ' ', ' ', ' ', ' '],
            ['X', 'O', 'O', ' ', ' ', 'O', ' ']
          ]
        )
        player = 'X'
        coords = [5, 2]
        result = game.someone_win?(coords, player)
        expect(result).to be false
      end
    end
    context 'When someone has won' do
      it 'returns true when X has four in a row horizontally' do
        game = described_class.new(
          [
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            ['O', 'O', 'O', ' ', ' ', ' ', ' '],
            ['X', 'X', 'X', 'X', ' ', ' ', ' ']
          ]
        )
        player = 'X'
        coords = [5, 3]
        result = game.someone_win?(coords, player)
        expect(result).to be true
      end
      it 'returns true when X has four in a row vertically' do
        game = described_class.new(
          [
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            ['X', ' ', ' ', ' ', ' ', ' ', ' '],
            ['X', ' ', ' ', ' ', ' ', ' ', ' '],
            ['X', ' ', ' ', ' ', ' ', ' ', ' '],
            ['X', 'O', 'O', ' ', ' ', 'O', ' ']
          ]
        )
        player = 'X'
        coords = [2, 0]
        result = game.someone_win?(coords, player)
        expect(result).to be true
      end
      it 'returns true when X has four in a row diagonally "up"' do
        game = described_class.new(
          [
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', 'X', ' ', ' ', ' '],
            [' ', ' ', 'X', 'O', ' ', ' ', ' '],
            [' ', 'X', 'O', 'O', ' ', ' ', ' '],
            ['X', 'O', 'O', 'X', 'X', ' ', ' ']
          ]
        )
        player = 'X'
        coords = [2, 3]
        result = game.someone_win?(coords, player)
        expect(result).to be true
      end
      it 'returns true when X has four in a row diagonally "down"' do
        game = described_class.new(
          [
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            ['X', ' ', ' ', ' ', ' ', ' ', ' '],
            ['X', 'X', ' ', ' ', ' ', ' ', ' '],
            ['O', 'O', 'X', ' ', ' ', ' ', ' '],
            ['O', 'O', 'O', 'X', ' ', 'X', ' ']
          ]
        )
        player = 'X'
        coords = [5, 3]
        result = game.someone_win?(coords, player)
        expect(result).to be true
      end
    end
  end

  describe '#make_move' do
    subject(:game) { described_class.new }
    context 'When move is valid' do
      it 'does not print "invalid location!" error message to screen' do
        error_message = 'Invalid location! Please choose a different column.'
        expect(game).not_to receive(:puts).with(error_message)
      end
    end

    context 'When user inputs 3 invalid moves, then a valid one' do
      it 'Displays the error message three times and then completes the loop' do
        error_message = 'Invalid location! Please choose a different column.'
        expect(game).to receive(:puts).with(error_message)
        expect(game).to receive(:puts).with(error_message)
        expect(game).to receive(:puts).with(error_message)
        expect(game).not_to receive(:puts).with(error_message)
      end
    end
  end
end
