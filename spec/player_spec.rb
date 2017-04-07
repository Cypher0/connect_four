require 'player'
require 'square'

describe 'Player' do
  let(:plr) { Player.new('name', 'X') }
  let(:grid) { Array.new(7) { Array.new(6) { Square.new } } }

  describe '#move' do

    context 'when column is empty' do
      it 'marks the column\'s last space' do
        plr.move(grid, 4)
        expect(grid[3][-1].color).to eql('X')
      end
    end

    context 'when column has occupied spaces' do
      it 'marks the first available space' do
        grid[3][-1] = Square.new('O', false)
        plr.move(grid, 4)
        expect(grid[3][-1].color).to eql('O')
        expect(grid[3][-2].color).to eql('X')
      end
    end
  end
end
