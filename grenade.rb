require 'curses'

include Curses

class Grenade
  attr_accessor :x, :y, :vx, :vy, :shape, :bounce

  def initialize(x = 20, y = 15)
    @x = x
    @y = y
    @vx = 6.0 #4.0
    @vy = -15.0
    @bounce = 0.8
    @shape = "@"
  end

  def update
    
  end
end

init_screen
HEIGHT = lines > 30 ? 30 : lines
WIDTH = cols > 80 ? 80 : cols
INTERVAL = 0.2
GRAV = 3

top = (Curses.lines - HEIGHT) / 2
left = (Curses.cols - WIDTH) / 2

grenade = Grenade.new
begin
  win = Curses::Window.new(HEIGHT, WIDTH, top, left)
  win.box("|", "-")
  win.refresh
  loop do 
    # place grenade
    x = grenade.x; y = grenade.y
    win.setpos(y, x)
    win << grenade.shape

    win.refresh
    # erase grenade
    win.setpos(y, x)
    win << " "
    #grenade.update
    grenade.vy += GRAV
    grenade.x += grenade.vx*INTERVAL
    grenade.y += grenade.vy*INTERVAL
    if grenade.y > HEIGHT - 2
      grenade.y = HEIGHT - 2
      grenade.vy = -grenade.vy * grenade.bounce
      grenade.vx -= 0.5
      grenade.vx = 0 if grenade.vx < 0
    end
    #grenade.explode if grenade.vx = 0
    bits = []
    bits.each do |bit|
      #make bits move
    end
    win.setpos(0,0)
    win << "x: #{x.to_i}, y: #{y.to_i}, vx: #{grenade.vx}, vy: #{grenade.vy}"
    sleep INTERVAL
  end



ensure
  win.close
end
