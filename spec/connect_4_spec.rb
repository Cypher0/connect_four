require 'connect_4'

describe 'ConnectFour' do

  let(:game) { ConnectFour.new('one', 'two') }

  describe '#switch_players' do

    context 'when player1 is active' do
      it 'switches to player2' do
        expect(game.switch_players).to eql(game.plr2)
      end
    end

    context 'when player2 is active' do
      it 'switches to player1' do
        game.act_plr = game.plr2
        expect(game.switch_players).to eql(game.plr1)
      end
    end
  end

  describe '#gen_v_line' do

    let(:line) { game.gen_v_line(game.grid[0][0], game.grid[0]) }

    it 'draws a line 4 spaces long' do
      expect(line.size).to eql(4)
    end

    it 'adds correct spaces to line' do
      4.times { game.plr1.move(game.grid, 1) }
      expect(line[0].color).to eql(line[1].color)
      expect(line[2].color).to eql(line[3].color)
      expect(line[0].color).to eql("\u25ef")
      expect(line[2].color).to eql(game.plr1.color)
    end
  end

  describe '#gen_h_line' do

    let(:line) { game.gen_h_line(game.grid[0][-1], game.grid[0]) }

    it 'draws a line 4 spaces long' do
      expect(line.size).to eql(4)
    end

    it 'adds correct spaces to line' do
      game.plr1.move(game.grid, 1)
      game.plr1.move(game.grid, 4)
      expect(line[0].color).to eql(line[3].color)
      expect(line[1].color).to eql(line[2].color)
    end
  end

  describe '#gen_rd_line' do

    let (:line) { game.gen_rd_line(game.grid[0][2], game.grid[0]) }

    it 'draws a line 4 spaces long' do
      expect(line.size).to eql(4)
    end

    it 'adds correct spaces to line' do
      game.plr1.move(game.grid, 4)
      2.times { game.plr1.move(game.grid, 3) }
      expect(line[0].color).to eql(line[1].color)
      expect(line[2].color).to eql(line[3].color)
      expect(line[0].color).to eql("\u25ef")
      expect(line[2].color).to eql(game.plr1.color)
    end
  end

  describe '#gen_ld_line' do

    let(:line) { game.gen_ld_line(game.grid[3][2], game.grid[3]) }

    it 'draws a line 4 spaces long' do
      expect(line.size).to eql(4)
    end

    it 'adds correct spaces to line' do
      game.plr1.move(game.grid, 1)
      2.times { game.plr1.move(game.grid, 2) }
      expect(line[0].color).to eql(line[1].color)
      expect(line[2].color).to eql(line[3].color)
      expect(line[0].color).to eql("\u25ef")
      expect(line[2].color).to eql(game.plr1.color)
    end
  end

  describe '#gen_v_lines' do

    it 'draws all possible vertical lines' do
      game.gen_v_lines
      expect(game.lines.size).to eql(21)
    end
  end

  describe '#gen_h_lines' do

    it 'draws all possible horizontal lines' do
      game.gen_h_lines
      expect(game.lines.size).to eql(24)
    end
  end

  describe '#gen_rd_lines' do

    it 'draws all possible diagonal-right lines' do
      game.gen_rd_lines
      expect(game.lines.size).to eql(12)
    end
  end

  describe '#gen_ld_lines' do

    it 'draws all possible diagonal-left lines' do
      game.gen_ld_lines
      expect(game.lines.size).to eql(12)
    end
  end

  describe '#win_cond?' do

    before { game.gen_lines }

    context 'when grid is empty' do
      it 'returns false' do
        expect(game.win_cond?).to be false
      end
    end

    context 'when a line has both colors' do
      it 'returns false' do
        2.times do
          game.plr1.move(game.grid, 1)
          game.plr2.move(game.grid, 1)
        end
        expect(game.win_cond?).to be false
      end
    end

    it 'detects vertical rows' do
      4.times { game.plr1.move(game.grid, 1) }
      expect(game.win_cond?).to be true
    end

    it 'detects horizontal lines' do
      (4..7).each do |i|
        game.plr1.move(game.grid, i)
      end
      expect(game.win_cond?).to be true
    end

    it 'detects diagonal lines' do
      col = 1
      (1..4).each do |i|
        i.times { game.plr1.move(game.grid, col) }
        col += 1
      end
      expect(game.win_cond?).to be true
    end
  end

  describe '#legal_move?' do

    context 'when target column is full' do
      it 'returns false' do
        6.times { game.plr1.move(game.grid, 1) }
        expect(game.legal_move?(1)).to be false
      end
    end

    context 'when target column is not full' do
      it 'returns true' do
        5.times { game.plr1.move(game.grid, 1) }
        expect(game.legal_move?(1)).to be true
        expect(game.legal_move?(7)).to be true
      end
    end

    it 'detects invalid input' do
      expect(game.legal_move?('a')).to be false
      expect(game.legal_move?(0)).to be false
      expect(game.legal_move?(66)).to be false
    end
  end
end
