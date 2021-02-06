require 'curses'
require 'pry'
require 'logger'

include Curses
class Drop
  attr_accessor :x, :y, :z, :shape, :speed

  def initialize(y = 10, x = 10, z = 10)
    @x = x
    @y = y
    @z = z
    @z = rand(1..10)
    @shape = '|'
    max_speed = 10
    min_speed = 4
    @speed = @z / 10.0 * (max_speed - min_speed) + min_speed
    # @speed  is 5 if z = 1, is 10 if z = 10
    # % should be ok
    @@speed = rand(min_speed..max_speed)
    @shape =  "\u2503" if speed > 8
  end
end

LOGFILE = 'log'
log = Logger.new(LOGFILE)
INTERVAL = 0.005
COLOR = 5

init_screen
HEIGHT = Curses.lines # 30#Curses.lines
WIDTH = Curses.cols # 80#Curses.cols
start_color
curs_set(0)
# noecho
#
init_pair(1, COLOR, 0) # set purple on black

drops = []
drops << Drop.new
300.times do |_i|
  drops << Drop.new(rand(0..HEIGHT), rand(0..WIDTH))
end
begin
  # win = Curses::Window.new(HEIGHT, WIDTH, 0,0)
  win = stdscr
  win.setpos(0, 0)
  win.attron(color_pair(1))
  loop do
    # win.clear

    drops.each do |drop|
      win.setpos(drop.y, drop.x)
      # win.attron(color_pair(1)) { win << drop.shape } #...we color it red
      win.addstr(drop.shape)
    end

    win.refresh
    # Kernel.select(nil,nil,nil, INTERVAL)
    # sleep INTERVAL

    drops.each do |drop|
      win.setpos(drop.y, drop.x)
      win << ' '
      drop.y += drop.speed * INTERVAL
      drop.y = 0 if drop.y > HEIGHT
    end
  end
rescue StandardError
ensure
  close_screen
end
