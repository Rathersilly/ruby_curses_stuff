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
    setpos(y0,x0)
    self << sym
    (x0..x1).each do |x|
      while err.abs > 0.5
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
    setpos(y1,x1)
    self << sym
  end

end

