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
end
