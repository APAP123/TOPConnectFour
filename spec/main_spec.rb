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
      it 'Lands at the bottom of the column (position 6)' do
        chosen_column = 3
        game.place_piece(chosen_column, 'X')
        bottom = game.instance_variable_get(:@board[chosen_column][6])
        expect(bottom).to equal('X')
      end
    end

    context 'When placing piece on column with 3 pieces already placed' do
      it 'Lands two spaces from the top (position 2)' do
        chosen_column = 3
        game.place_piece(chosen_column, 'X')
        middle = game.instance_variable_get(:@board[chosen_column][2])
        expect(middle).to equal('X')
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
