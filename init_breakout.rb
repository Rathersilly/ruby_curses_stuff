require 'curses'
include Curses
require 'io/console'


class Thing
  attr_accessor :row, :col, :length, :color, :image, :pixels

  def initialize(row, col, color = COLOR_RED)
    @row = row - 3
    @col = col  / 2
    @color = color
  end
  def update
  end
end

class Bar < Thing
  def initialize(row, col, color = COLOR_RED, length = 9)
    @length = length
    #@image = "111333555" 
    @image = "5" * length
    super(row, col, color)
    update_pixels
  end
  def update_pixels

    @pixels = []
    @length.times { |c| @pixels << [row,col + c] }

  end
end
class Ball < Thing
  attr_accessor :vx, :vy
  def initialize(row, col, color = COLOR_BLUE)
    @image = "@"
    @color = color
    @vx = 1
    @vy = 1
    super(row, col, color)
  end

  def update

  end


end
class Game
  def initialize(args = {})
    @msg = ''

    @things = []
    @bar = Bar.new(Win.maxy, Win.maxx - 3)
    @ball = Ball.new(10, 10)
    @things << @bar
    @things << @ball
    @key = ''
    @frame = 0

    start unless args[:test] == true
  end
end
