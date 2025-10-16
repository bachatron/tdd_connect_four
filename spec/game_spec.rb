require_relative '../lib/game.rb'

describe Game do

  describe '#verify_input' do
    subject(:new_game) { described_class.new }
    
    context 'when input is a valid option' do
      it 'return valid input' do
        user_input = '4'
        verified_input = new_game.verify_input(user_input)
        expect(verified_input).to eq('4')        
      end
    end

    context 'when the input is invalid' do
      it 'returns nil' do
      user_input = 'a'
      verified_input = new_game.verify_input(user_input)
      expect(verified_input).to be_nil
      end
    end
  end

  describe '#is_full?' do
    subject(:new_game) { described_class.new }
    context 'when the last slot is full' do
      before do
        new_game.board['a'][2] = new_game.p1
      end
      it 'it returns true' do
        move = '2'
        full = new_game.is_full?(2)
        expect(full).to be true
      end
    end
  end

  describe '#empty_position' do
    subject(:new_game) { described_class.new }
    context 'check the next empty row position' do
      before do
        new_game.board['f'][0] = new_game.p1
        new_game.board['e'][0] = new_game.p1
      end
      it 'returns the next empty position' do
        empty_position = new_game.empty_position(0)
        expect(empty_position).to eq('d')
      end
    end
  end

        

    
end

