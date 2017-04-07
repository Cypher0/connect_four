class Square
  attr_accessor :color, :empty

  def initialize(color = "\u25ef", empty = true)
    @color = color
    @empty = empty
  end
end
