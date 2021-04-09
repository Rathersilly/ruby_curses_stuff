class Curses::Window
  def gost(y,x,*strings)
    setpos(y,x)
    strings.each do |s|
      self << s.to_s << " "
    end
  end
  def attach(shape)
    shape.win = self
  end
  def draw_line(y0,x0,y1,x1, sym = "X")
    gost 6,0,"          "
    gost 10,20, "line 10: "
    gost 25,20, "line 25:------- "
    gost 8,30, "|"
    # may need to do rounding because of circle
    if x0 > x1
      x0, x1 = x1, x0
      y0, y1 = y1, y0
    end
    if x1 - x0 == 0
      (y1-y0) > 0 ? m = 1 : m = -1
      err = y1-y0.to_f
    else
      m = (y1 - y0)/(x1 - x0.to_f)
      err = 0.0
    end
    y = y0
    gost 0,0,y0,x0," to ",y1,x1, " m = ",m
    setpos(y0,x0)
    self << sym
    (x0..x1).each do |x|
      gost 2,0,"xloop: ",x,y,err
      #getch
      while err.abs > 0.5
        gost 4,0,"while loop",x,y,err
        #getch
        if err > 0
          y += 1
          err -= 1
          break if y > y1
        elsif err < 0
          y -= 1
          err += 1
          break if y < y1
        end
        setpos(y,x)
        self << sym
      end
      err += m
      setpos(y,x)
      self << sym
    end
    gost 6,0,"HERE"
    #getch
    setpos(y1,x1)
    self << sym
  end
end
class Point
  attr_accessor :x,:y
  def initialize(y,x)
    @x = x
    @y = y
  end
end
class Shape
  attr_accessor :win, :color
  def initialize
    @color = :white
  end
end
class Circle < Shape
  # Circle must be attached to a window
  attr_accessor :cx,:cy,:r

  def initialize(cy,cx,r)
    # center coordinates
    #@win = Win
    @cx = cx.to_f
    @cy = cy.to_f
    @r = r.to_f
    # nls = number of line segments
    @nls = 30
    @coords = []
  end
  
  def draw
    #start at 0 radians
    #first point is x,y
    x = @cx + r
    y = @cy
    dist = @nls/(2*Math::PI)
    ny = 
    loop do
      # draw line segment 
      @win.draw_line(@cy,@cx,@cy,@cx)
      break
    end
  end

  def coords
  end



end

