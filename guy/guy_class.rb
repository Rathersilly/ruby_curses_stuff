class Guy
  attr_accessor :y, :x, :vy, :vx, :dir, :dest

  def initialize(y,x)
    @y = y
    @x = x
    @dest = nil
    @count = 0
    @diry = @y + 1
    @dirx = @x + 1
    @sight_angle = Math::PI/2
    @sight_dist = 100
  end
  def update
    @dest[0] = rand(Map.maxy)
    @dest[1] = rand(Map.maxx)
    Map.setpos(@dest[0],@dest[1])
    @count += 1
    Map << @count.to_s

    dist = Math.sqrt((@dest[0] - @y)**2 + (@dest[1] - @x) ** 2)
    Win.setpos(1,5)
    Win << "dist: " << dist.to_s
    dy = @y - @dest[0].to_f
    dx = @dest[1]-@x.to_f
    Win.setpos(2,5)
    Win << "dy,dx: #{dy}, #{dx}"
    @dir = Math.atan2(dy,dx)
    Win.setpos(3,5)
    Win << "dir: #{@dir}"
    Win.setpos(7,5)
    Win << "angle: #{@dir.to_s}"

    Win.setpos(9,5)
    Win << "angle in deg: #{@dir*57}"
    
    #find pixel next to guy closest to dest  
    #best to break things into sections
    
    get_dirxy
    
    get_sight

  end
  def get_sight
    #Map.draw_line(@y,@x,y,x)
    #Map.draw_line(@y,@x,dest[0],dest[1])
    #Map.line_through(@y,@x,y,x)
    #Map.draw_line_through
    Map.draw_line_through(@y,@x,dest[0],dest[1])


  end

  def get_dirxy
    Map.setpos(@diry, @dirx)
    Map << " "
    if 0 <= @dir && @dir < Math::PI/8
      @diry =@y
      @dirx = @x + 1
      Map.setpos(@diry, @dirx)
      Map << "-"
    elsif Math::PI * 3/8 > @dir && @dir > Math::PI/8
      @diry = @y - 1
      @dirx = @x  + 1
      Map.setpos(@diry, @dirx)
      Map << "/"
    elsif Math::PI * 5/8 > @dir && @dir > Math::PI * 3/8
      @diry = @y - 1
      @dirx = @x
      Map.setpos(@diry, @dirx)
      Map << "|"
    elsif Math::PI * 7/8 > @dir && @dir > Math::PI * 5/8
      @diry = @y - 1
      @dirx = @x  - 1
      Map.setpos(@diry, @dirx)
      Map << "\\"
    elsif Math::PI  >= @dir && @dir > Math::PI * 7/8
      @diry = @y 
      @dirx = @x - 1
      Map.setpos(@diry, @dirx)
      Map << "-"
    elsif 0 > @dir && @dir > Math::PI * -1/8
      @diry = @y 
      @dirx = @x + 1
      Map.setpos(@diry, @dirx)
      Map << "-"
    elsif Math::PI * -3/8 <  @dir && @dir < Math::PI * -1/8
      @diry = @y + 1
      @dirx = @x + 1
      Map.setpos(@diry, @dirx)
      Map << "\\"
    elsif Math::PI * -5/8 <  @dir && @dir < Math::PI * -3/8
      @diry = @y + 1
      @dirx = @x 
      Map.setpos(@diry, @dirx)
      Map << "|"
    elsif Math::PI * -7/8 <  @dir && @dir < Math::PI * -5/8
      @diry = @y + 1
      @dirx = @x - 1
      Map.setpos(@diry, @dirx)
      Map << "/"
    elsif Math::PI * -1 <  @dir && @dir < Math::PI * -7/8
      @diry = @y 
      @dirx = @x - 1
      Map.setpos(@diry, @dirx)
      Map << "-"

    end
  end

end

