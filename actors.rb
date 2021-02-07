class Thing
  attr_accessor :x, :y, :vx, :vy
  def initialize(x = 20, y = 10, vx = 6.0, vy = 0.0)
  def update
  end
end
end
class Dot < Thing
  @@count = 0
  attr_accessor :x, :y, :vx, :vy, :shape, :name
  def initialize(x = 20, y = 10)
    @x = x
    @y = y
    @@count += 1
    @shape = "X"
    @name = "Dot#{@@count}"
  end
  def update
  end
end
class Grenade # < Thing
  attr_accessor :x, :y, :vx, :vy, :shape, :bounce_ratio, :name, :spent,:bounces, :angle
  @@count = 0

  def initialize(x = 20, y = 10, vx = 6.0, vy = 0.0)
    @x = x
    @y = y
    @vx = vx
    @vy = vy
    @bounce_ratio = 0.5 # 0.8
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
