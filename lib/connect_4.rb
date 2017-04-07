require_relative 'square'
require_relative 'player'

class ConnectFour
  attr_accessor :grid, :plr1, :plr2, :act_plr, :lines

  def initialize(name1, name2)
    @plr1 = Player.new(name1, "\u2605")
    @plr2 = Player.new(name2, "\u2606")
    @act_plr = @plr1
    @grid = Array.new(7) { Array.new(6) { Square.new } }
    @lines = [] # for storing all possible winning conditions
  end
  
  # take a space as an argument, draw a vertical 4-space line starting with it
  def gen_v_line(start, col)
    line = []
    i = col.index(start)
    4.times do
      line << col[i]
      i += 1
    end
    line
  end

  def gen_h_line(start, col, grid = @grid)
    line = []
    sq_i = col.index(start)
    col_i = grid.index(col)
    4.times do
      line << grid[col_i][sq_i]
      col_i += 1
    end
    line
  end

  def gen_rd_line(start, col, grid = @grid)
    line = []
    sq_i = col.index(start)
    col_i = grid.index(col)
    4.times do
      line << grid[col_i][sq_i]
      col_i += 1
      sq_i += 1
    end
    line
  end

  def gen_ld_line(start, col, grid = @grid)
    line = []
    sq_i = col.index(start)
    col_i = grid.index(col)
    4.times do
      line << grid[col_i][sq_i]
      col_i -= 1
      sq_i += 1
    end
    line
  end

  # loop through all possible starts for a vertical line, draw the lines and add them
  #   to @lines
  def gen_v_lines(grid = @grid)
    grid.each do |col|
      col[0..-4].each do |sq|
        @lines << gen_v_line(sq, col)
      end
    end
  end

  def gen_h_lines(grid = @grid)
    grid[0..-4].each do |col|
      col.each do |sq|
        @lines << gen_h_line(sq, col)
      end
    end
  end

  def gen_rd_lines(grid = @grid)
    grid[0..-4].each do |col|
      col[0..-4].each do |sq|
        @lines << gen_rd_line(sq, col)
      end
    end
  end

  def gen_ld_lines(grid = @grid)
    grid[3..-1].each do |col|
      col[0..-4].each do |sq|
        @lines << gen_ld_line(sq, col)
      end
    end
  end

  def gen_lines(grid = @grid)
    gen_v_lines(grid)
    gen_h_lines(grid)
    gen_rd_lines(grid)
    gen_ld_lines(grid)
  end

  def switch_players
    @act_plr = if @act_plr == @plr1
                 @plr2
               else
                 @plr1
               end
  end

  def legal_move?(i)
    i.to_i.between?(1, 7) && @grid[i.to_i - 1].any?(&:empty)
  end

  def input_move
    puts "\n#{@act_plr.name}, where would you like to move(pick a column from 1 to 7)?"
    input = gets.chomp
    if legal_move?(input)
      input.to_i
    else
      puts 'Invalid move, try again.'
      input_move
    end
  end

  def disp_grid(grid = @grid)
    print "\n"
    (0..6).each { |i| print ["246#{i}".to_i(16)].pack('U*') + ' ' }
    print "\n"
    (0..5).each do |i|
      grid.each do |col|
        print "#{col[i].color} "
      end
      print "\n"
    end
  end

  def win_cond?
    @lines.any? { |line| line.all? { |sq| sq.color == @plr1.color } } ||
      @lines.any? { |line| line.all? { |sq| sq.color == @plr2.color } }
  end

  def game_over?
    win_cond? || @grid.all? { |col| col.all? { |sq| sq.empty == false } }
  end

  def play
    gen_lines
    until game_over?
      switch_players
      disp_grid
      @act_plr.move(@grid, input_move)
    end
    disp_grid
    puts win_cond? ? "\nGame over, #{@act_plr.name} won!" : "\nGame over, it's a draw!"
  end
end
