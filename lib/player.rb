class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def move(grid, column = gets.chomp)
    col = grid[column - 1]
    n = -1
    n -= 1 until col[n].empty
    col[n].color = @color
    col[n].empty = false
  end
end
