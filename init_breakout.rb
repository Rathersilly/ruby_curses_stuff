require 'curses'
include Curses
require 'io/console'

class Thing
  attr_accessor :row, :col, :length, :color, :image

  def initialize(row, col, color = COLOR_RED)
    @row = row - 3
    @col = col  / 2
    @color = color
  end
end

class Bar < Thing
  def initialize(row, col, color = COLOR_RED, length = 7)
    @length = length
    @image = "X" * length
    super(row, col, color)
  end
end
class Ball < Thing
  def initialize(row, col, color = COLOR_RED)
    @image = "@"
    super(row, col, color)
  end

end
class Game
  def initialize(args = {})

    init_screen
    @win = stdscr.derwin(30, 50, 0, 0)

    curs_set(0) # 0=invis, 1=vis, 2=veryvis
    cbreak # disables line buffering - turn off w/ nocbreak
    noecho
    @win.timeout = 0
    @win.box("|", "-")
    @things = []
    @bar = Bar.new(@win.maxy, @win.maxx - 3)
    @ball = Ball.new(10, 10)
    @things << @bar
    @things << @ball
    start unless args[:test] == true
  end
end
