class Curses::Window
  def draw_line(*args)
    if args.size == 4
      y0,x0,y1,x1 = args
      coords = line_coords(y0,x0,y1,x1)
    end
    if args.size == 3
      y, x, angle = args
    end
    coords.each do |coord|
      y = coord[0]; x = coord[1];
      setpos(y,x)
      self << "%"
    end
  end
  def draw_line_through(y0,x0,y1,x1)
    dy = y1 - y0.to_f
    dx = x1 - x0.to_f
    if dy > dx
      dx /= dy
      dy = 1.0
    else
      dy /= dx
      dx = 1.0
    end
    y = y0
    x = x0

    while true
      if x <= 0
        x = 0
        break
      elsif x >= Map.maxx - 1 
         x = Map.maxx - 1 
         break
      elsif y <= 0
        y = 0
         break
      elsif y >= Map.maxy - 1 
         y = Map.maxy - 1 
         break
      end
      y += dy
      x += dx
    end
    y = y.to_i
    x = x.to_i
    draw_line(y0,x0,y,x)
  end

  def line_coords(y0,x0,y1,x1)
    #should return coords to draw
    coords = []
    if x0 > x1
      x0,x1 = x1,x0
      y0,y1 = y1,y0
    end
    m = (y1.to_f - y0)/(x1.to_f - x0)
    y = y0
    x = x0
    dy = y1-y0
    dx = x1-x0
    dy = dy.to_f
    dx = dx.to_f
    derr =(dy/dx).abs
    err = 0.0

    (x0..x1).each do |x|
      err = err + derr
      coords << [y,x]if err <= 0.5
      qflag = 0
      while err > 0.5
        if m < 0
          y = y - 1
          qflag = 1 if y < y1
        else
          y = y + 1
          qflag = 1 if y > y1
        end
        break if qflag == 1
        coords << [y,x]
        err = err - 1.0
      end
    end
    coords
  end
end

def draw_demo

  Map.draw_line(::Midy,::Midx,@y,::Midx + @x)
  Map.draw_line(::Midy,::Midx,@y,::Midx - @x)
  @y += 1
  @y = 3 if @y == Map.maxy
end
# These TEMP fns are from when i didnt return coords with draw line function
def draw_lineTEMP(y0,x0,y1,x1)
  #should return coords to draw
  coords = []
  if x0 > x1
    x0,x1 = x1,x0
    y0,y1 = y1,y0
  end
  m = (y1.to_f - y0)/(x1.to_f - x0)
  Log.puts "in draw_line"
  Log.puts "#{y0}, #{x0}, #{y1}, #{x1}"
  y = y0
  x = x0
  dy = y1-y0
  dx = x1-x0
  dy = dy.to_f
  dx = dx.to_f
  derr =(dy/dx).abs
  err = 0.0

  (x0..x1).each do |x|
    Log.puts "y: #{y}, x: #{x}, m: #{m}, err: #{err}"
    Win.setpos(12,5)
    Win << "y: #{y}, x: #{x}, m: #{m}"
    Win.setpos(13,5)
    Win << "derr: #{derr}, err: #{err}"
    Map.setpos(y,x)
    coords << [y,x]
    err = err + derr
    Map << "%" if err <= 0.5
    qflag = 0
    while err > 0.5
      if m < 0
        y = y - 1
        qflag = 1 if y < y1
      else
        y = y + 1
        qflag = 1 if y > y1
      end
      break if qflag == 1
      Map.setpos(y,x)
      coords << [y,x]
      Map << "O"
      err = err - 1.0
    end
  end
  coords
end
def draw_demoTEMP
  #draw_line(15,25,y,x)
  draw_line(::Midy,::Midx,@y,::Midx + @x)
  draw_line(::Midy,::Midx,@y,::Midx - @x)
  #draw_line(::Midy,::Midx,y,::Midx - x)
  Win.setpos(20,5)
  Win << "end1: #{@y}, #{::Midx + @x}"
  Win.setpos(21,5)
  Win << "end2: #{@y}, #{::Midx - @x}"
  @y += 1
  @y = 3 if @y == Map.maxy
  #x = 10 if x > 30

end