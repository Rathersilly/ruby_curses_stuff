require 'curses'
include Curses
require 'io/console'

#need structure of patterns
#first one - 


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
  def initialize(row, col, color = COLOR_RED, length = 11)
    @length = length
    @image = "11113335555" 
    #@image = "5" * length
    # @pixels is an array of all the coordinates that the bar occupies
    @pixels = []
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
class Block < Thing
  def initialize(row, col, color = COLOR_YELLOW, length = 5)
    @row = row
    @col = col
    @length = length
    @image = "\u2588" * length
    @color = color
    @damage = 0
    @image_damaged = "\u259A" * length
  end

end


class Game
  def initialize(args = {})
    @msg = ''

    @things = []
    @bar = Bar.new(Win.maxy, Win.maxx - 3)
    @ball = Ball.new(5, 10)
    @things << @bar
    @things << @ball
    @key = ''
    @frame = 0

    get_level_pattern

    # @msg2 = @things.inspect

    start unless args[:test] == true
  end

  def get_level_pattern
    
    3.times do |i|
      (0..11).each do |n|
        length = 3
        n.even? ? color = COLOR_YELLOW : color = COLOR_GREEN
        @things << Block.new(4 + i * 2, n*length + 1, color, length)
      end
    end
  end

end
