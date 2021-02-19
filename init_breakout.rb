require 'curses'
include Curses
require 'io/console'

init_screen
# Win = stdscr.derwin(30, 50, 0, 0)
Win = stdscr.derwin(20, 38, 10, 10)
# Win = stdscr.derwin(11, 13, 5, 10)
Rows = Win.maxy; Cols = Win.maxx

curs_set(0) # 0=invis, 1=vis, 2=veryvis
cbreak # disables line buffering - turn off w/ nocbreak
noecho
stdscr.keypad = true
# Win.keypad = true 
stdscr.timeout = 0
start_color
init_pair(1, 1, 0)
init_pair(2, 2, 0)
init_pair(3, 3, 0)
init_pair(4, 4, 0)
init_pair(7, 0, COLOR_BLUE)
Bar_pair = 12
init_pair(Bar_pair, COLOR_BLACK, COLOR_BLUE)
Win.box("|", "-")

count = 1
#need structure of patterns
#first one - 


class Thing
  attr_accessor :row, :col, :length, :color, :image, :pixels

  def initialize(row, col, color = COLOR_RED)
    @row = (row - 3).to_f
    @col = (col  / 2).to_f
    @color = color
  end
  def update
  end
end

class Bar < Thing
  def initialize(row, col, color = Bar_pair, length = 11)
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
  attr_accessor :vx, :vy, :prevx, :prevy
  def initialize(row, col, color = COLOR_BLACK)
    @image = "@"
    @color = color
    @vx = (1).to_f
    @vy = (1).to_f
    @prevx = (0).to_f
    @prevy = (0).to_f

    super(row, col, color)
  end

  def update
  end
end
class Block < Thing
  attr_accessor :damage, :image_damaged
  def initialize(row, col, color = COLOR_YELLOW, length = 5)
    @row = row
    @col = col
    @length = length
    @image = "\u2588" * length
    @color = color
    @damage = 0
    @image_damaged = "\u259A" * length
    @pixels =  []
    @length.times { |c| @pixels << [row,col + c] }
  end

end


class Game
  def initialize(args = {})
    @msg = ''

    @things = []
    @bar = Bar.new(Win.maxy, Win.maxx - 3)
    @ball = Ball.new(Cols / 2, Rows - 10)
    @things << @bar
    @things << @ball
    @key = ''
    @frame = 0


    @blocks = []
    get_level_pattern
    

    # @msg2 = @things.inspect

    start unless args[:test] == true
  end

  def get_level_pattern
    
    4.times do |i|
      (0..8).each do |n|
        length = 4
        n.even? ? color = COLOR_YELLOW : color = COLOR_GREEN
        @blocks << Block.new(4 + i * 2, n*length + 1, color, length)
      end
    end
  end

end
