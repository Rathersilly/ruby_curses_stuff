require 'curses'
require 'logger'

include Curses

class Grenade
  attr_accessor :x, :y, :vx, :vy, :shape, :bounce_ratio, :name, :spent,:bounces
  @@count = 0

  def initialize(x = 20, y = 10, vx = 6.0, vy = 0.0)
    @x = x
    @y = y
    @vx = vx
    @vy = vy
    @bounce_ratio = 0.4 # 0.8
    @shape = "@"
    @@count += 1
    @name = "Grenade#{@@count}"
    @spent = false
    @bounces = 0

  end

  def update
    @vy += GRAV
    @x += @vx*INTERVAL
    @y += @vy*INTERVAL
    if @y > HEIGHT - 2
      @y = HEIGHT - 2
      @vy = -@vy * @bounce_ratio
      @vx -= 0.5
      @vx = 0 if @vx < 0
      @bounces += 1
      if @bounces > BOUNCES_BEFORE_EXPLODE
        @y = HEIGHT - 2
        @vx = 0
        @vy = 0
        @shape = "."
      end
    end
    if @x > WIDTH - 2
      @x = WIDTH - 2
      @vx = -@vx
    elsif @x < 1
      @x = 1
      @vx = -@vx
    end
  end

end

class Shrapnel
  attr_accessor :x, :y, :vx, :vy, :shape, :bounce, :name, :angle
  def initialize(x, y, angle)
    @x = x; @y = y
    @vx = Math.cos(angle) * SHRAPNEL_SPEED 
    @vy = Math.sin(angle) * SHRAPNEL_SPEED 
    @angle = angle
    @name = "Shrapnel #{angle}"
    @shape = "*"

  end
  def update
    @vy += GRAV
    @x += @vx*INTERVAL
    @y += @vy*INTERVAL
    if @y > HEIGHT - 1
      @y = HEIGHT  - 1

      # @vy = -@vy * @bounce
      @vx = 0
      @vy = 0
    end
  end
end

log = Logger.new("log")
                 
  
init_screen
HEIGHT = lines > 30 ? 30 : lines
WIDTH = cols > 80 ? 80 : cols
INTERVAL = 0.2
GRAV = 3
BOUNCES_BEFORE_EXPLODE = 2
SHRAPNEL_SPEED = 25.0

top = (Curses.lines - HEIGHT) / 2
left = (Curses.cols - WIDTH) / 2

grenade = Grenade.new
actors = []
actors << grenade
actors << Grenade.new(20,15,9.0,-10)
active_nades = 2
begin
  win = Curses::Window.new(HEIGHT, WIDTH, top, left)
  win.box("|", "-")
  win.refresh
  loop do 
    if active_nades < 4
      actors << Grenade.new(rand(HEIGHT), rand(WIDTH), rand(-20..20), rand(-20..20))
      active_nades += 1
    end

    # Draw actors
    actors.each do |actor|
      log.info("#{actor.name}: win.setpos(#{actor.y}, #{actor.x})")
      win.setpos(actor.y, actor.x)
      win << actor.shape
      win.setpos(0,0)
      win << "x: #{actor.x.to_i}, y: #{actor.y.to_i}, vx: #{actor.vx}, vy: #{actor.vy}"
    end

    win.refresh
    actors.each do |actor|
      break if actor.y.nil? or actor.x.nil?
      win.setpos(actor.y, actor.x)
      win << " "
    end
    actors.each do |actor|
      actor.update
      if actor.name.include?("Grenade") && actor.bounces > BOUNCES_BEFORE_EXPLODE && !actor.spent
        actor.spent = true
        active_nades -= 1
        (0..7).each do |i|
          actors << Shrapnel.new(actor.x, actor.y , *i * Math::PI/4 + rand(-1..1)* Math::PI/12)
        end
      end
    end


    #win.setpos(0,0)
    #win << "x: #{actor.x.to_i}, y: #{actor.y.to_i}, vx: #{actor.vx}, vy: #{actor.vy}"
    sleep INTERVAL
  end



ensure
  win.close
end
