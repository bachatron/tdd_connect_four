require_relative '../lib/game'

RSpec.describe Game do
  let(:game) { Game.new }

  describe '#new_board' do
    it 'creates a 6x7 board filled with ❍' do
      board = game.new_board
      expect(board.keys.size).to eq(6)
      expect(board['a'].size).to eq(7)
      expect(board.values.flatten.uniq).to eq(['❍'])
    end
  end

  describe '#verify_input' do
    it 'returns true for valid column numbers (1–7)' do
      expect(game.verify_input('1')).to be true
      expect(game.verify_input('7')).to be true
    end

    it 'returns false for invalid input' do
      expect(game.verify_input('0')).to be false
      expect(game.verify_input('9')).to be false
      expect(game.verify_input('a')).to be false
    end
  end

  describe '#lowest_empty_row' do
    it 'returns the lowest empty row in the given column' do
      expect(game.lowest_empty_row(0)).to eq('a')
      game.drop_disc(0)
      expect(game.lowest_empty_row(0)).to eq('b')
    end
  end

  describe '#drop_disc' do
    it 'places the current player token in the correct cell' do
      game.drop_disc(0)
      expect(game.board['a'][0]).to eq('➊')
    end
  end

  describe '#switch_player' do
    it 'switches between players ➊ and ➋' do
      expect { game.switch_player }.to change { game.instance_variable_get(:@current_player) }.from('➊').to('➋')
    end
  end

  describe '#winner?' do
    context 'when there is a horizontal win' do
      it 'returns true if a player has 4 in a row horizontally' do
        # simulate four ➊ discs in a row on the bottom row (a)
        (0..3).each { |col| game.board['a'][col] = '➊' }
        expect(game.winner?).to be true
      end
    end

    context 'when there is a vertical win' do
      it 'returns true if a player has 4 in a row vertically' do
        # simulate four ➋ discs in the first column
        %w[a b c d].each { |row| game.board[row][0] = '➋' }
        game.instance_variable_set(:@current_player, '➋')
        expect(game.winner?).to be true
      end
    end

    context 'when there is no win' do
      it 'returns false if no player has four in a row' do
        game.board['a'][0] = '➊'
        game.board['a'][1] = '➋'
        game.board['a'][2] = '➊'
        game.board['a'][3] = '➋'
        expect(game.winner?).to be false
      end
    end
  end
end
