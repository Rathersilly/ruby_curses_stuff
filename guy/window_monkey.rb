class Curses::Window
  def gost(y,x,*strings)
    # GO to y,x and print STring(s)
    setpos(y,x)
    strings.each do |s|
      self << s.to_s << " "
    end
  end

  def attach(thing)
    thing.win = self
  end

  def draw_line(*args)
    if args.size >= 4
      y0,x0,y1,x1 = args
      options = args[4] if args[4]
    elsif args.size == 2
      # deal with points
    end
    coords = []

    sym = "X"
    # may need to do rounding because of circle
    if x0 > x1              # so can iterate x increasing
      x0, x1 = x1, x0
      y0, y1 = y1, y0
    end

    if x1 - x0 == 0         # vertical line
      (y1-y0) > 0 ? m = 1 : m = -1
      err = y1-y0.to_f
    else
      m = (y1 - y0)/(x1 - x0.to_f)
      err = 0.0
    end

    y = y0
    setpos(y0,x0)
    self << sym
    coords << [y0,x0]
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
        coords << [y,x]
      end
      err += m
      setpos(y,x)
      self << sym
      coords << [y,x]
    end
    setpos(y1,x1)
    self << sym
    coords << [y1,x1]
    coords
  end
  def draw_arc(cy,cx,a0,a1,r,step=Math::PI/64)
    a1,a0 = a0,a1 if a1 < a0
    theta = a0
    while theta < a1
      y = (r * Math.sin(theta)).round
      x = (r * Math.cos(theta)).round
      setpos(cy+y,cx+x)
      self << "X"
      theta += step
    end

  end

  def wedge(cy,cx,a0,a1,r,step=Math::PI/64)
    draw_arc(cy,cx,a0,a1,r,step=Math::PI/64)
    pty = r* Math.sin(a0) + cy
    ptx = r* Math.cos(a0) + cx
    draw_line(cy,cx,pty.round,ptx.round)
    pty = r* Math.sin(a1) + cy
    ptx = r* Math.cos(a1) + cx
    draw_line(cy,cx,pty.round,ptx.round)
  end

  def rectf(*args)
    options = {color: White,sym: 'X'}
    if false#args.size < 4
      # deal with point
    elsif args.size  < 6
      y0,x0,w,h = args
      if args[4] && args[4].class == Hash
        options.update args[4]
      end
      x = x0
      attron(color_pair(options[:color]))
      while x <= x0 + w
        y = y0
        while y <= y0 + h
          setpos(y,x)
          self << options[:sym]
          y += 1
        end
        x += 1
      end
      attroff(color_pair(options[:color]))
    end
  end

  # filled in wedge - best to do geometrically i think
  def pie(cy,cx,a0,a1,r,step=Math::PI/64)
    # ok this pie fn just draws a bunch of lines
    # from center to radius - not elegant
    a1,a0 = a0,a1 if a1 < a0
    theta = a0
    while  theta < a1
      y = (r* Math.sin(theta) + cy).round
      x = (r* Math.cos(theta) + cx).round
      draw_line(cy,cx,y,x)
      theta+= step/4
    end
  end
end




