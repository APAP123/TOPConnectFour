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
        game = Game.new(Array.new(7) { Array.new(7, 'X') })
        chosen_column = 1
        result = game.valid_move?(chosen_column)
        expect(result).to be false
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
