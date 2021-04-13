class Curses::Window
  def gost(y,x,*strings)
    # GO to y,x and print STring(s)
    setpos(y,x)
    strings.each do |s|
      self << s.to_s << " "
    end
  end

  def attach(shape)
    shape.win = self
  end

  #def draw_line(y0,x0,y1,x1, sym = "X")
  def draw_line(*args)

    if args.size >= 4
      y0,x0,y1,x1 = args
      options = args[4] if args[4]
    elsif args.size == 2
      # deal with points
    end
    dest = options[:dest] rescue nil
    dest ||= self
    coords = []

    sym = "X"
    # may need to do rounding because of circle

    if x0 > x1
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
    coords << [y0,x0]
    dest << sym
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
        coords << [y,x]
        dest << sym
      end
      err += m
      setpos(y,x)
      coords << [y,x]
      dest << sym
    end
    setpos(y1,x1)
    coords << [y1,x1]
    dest << sym
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

  # filled in wedge
  # algo options: just a bunch of lines with small
  # angle steps.
  # could test direction of wedge
  # use that to iterate and draw from left to right
  # could check window char to see when to end.
  # seems imprecise
  # maybe start with rectangle?
  #
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


  def pie(cy,cx,a0,a1,r,step=Math::PI/32)
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

  def pie2(cy,cx,a0,a1,r,step=Math::PI/32)
    Log.puts "In Pie"
    # aaah actually can rely on acute angles because
    # can subdivide obtuse into acute
    wedge(cy,cx,a0,a1,r,step=Math::PI/32)
    # get corners m,n
    my = (r* Math.sin(a0) + cy).round
    mx = (r* Math.cos(a0) + cx).round
    ny = (r* Math.sin(a1) + cy).round
    nx = (r* Math.cos(a1) + cx).round
    setpos(my-2,nx)
    self << '|'
    setpos(17,60)
    self << "17"

    #x = mx
    #y = my
    #find quadrant
    dy = ny-my
    dx = nx-mx
    x = nx
    if dy > 0
      if dx < 0
        (my..ny).each do |y|
          x = nx
          setpos(y,x)
          Log.puts y,x
          Log.print "***"
          Log.puts inch
          next if inch != 32
          Log.puts "still here"
          x = nx
          loop do
            setpos(y,x)
            break unless inch == 32
            self << '%'
            x += 1
          end
          x = nx - 1
          loop do
            setpos(y,x)
            break unless inch == 32

            self << '%'
            #self.refresh
            #self.getch
            x -= 1
          end

        end
      end
    end
  end

  def pie3(cy,cx,a0,a1,r,step=Math::PI/32)
    # lmao getting there
    # might be easiest to just draw border in diff
    # characters, to differentiate what is filled
    Log.puts "In Pie"
    wedge(cy,cx,a0,a1,r,step=Math::PI/32)
    # get corners m,n
    my = (r* Math.sin(a0) + cy).round
    mx = (r* Math.cos(a0) + cx).round
    ny = (r* Math.sin(a1) + cy).round
    nx = (r* Math.cos(a1) + cx).round
    linecord = draw_line(cy,cx,my,mx)#,dest: [])
    otherline = draw_line(cy,cx,ny,nx)#,dest: [])
    if my > ny
      linecord, otherline = otherline, linecord
    end
    Log.puts linecord.inspect
    Log.puts otherline.inspect
    #x = mx
    #y = my
    #find quadrant
    dy = ny-my
    dx = nx-mx
    if true#dy > 0
      if true#dx < 0
        # iterating top to bottom
        linecord.each do |y,x|
          setpos(y,x)
          next if otherline.include? [y,x] ||
            inch == 32 ||
            (y-cy).abs ** 2 + (x-cx).abs ** 2 > r ** 2
          y += 1
          break if (y-cy).abs ** 2 + (x-cx).abs ** 2 > r ** 2
          setpos(y,x)
          while inch == 32
            self << 'X'
            y += 1
            break if (y-cy).abs ** 2 + (x-cx).abs ** 2 > r ** 2
            setpos(y,x)
            #Win.refresh
            #Win.getch
          end
        end
        # iterating left to right
    if mx < nx
      linecord, otherline = otherline, linecord
    end
        linecord.each do |y,x|
          setpos(y,x)
          next if otherline.include? [y,x] ||
            inch == 32 ||
            (y-cy).abs ** 2 + (x-cx).abs ** 2 > r ** 2
          x += 1
          break if (y-cy).abs ** 2 + (x-cx).abs ** 2 > r ** 2
          setpos(y,x)
          while inch == 32
            self << 'X'
            x += 1
            break if (y-cy).abs ** 2 + (x-cx).abs ** 2 > r ** 2
            setpos(y,x)
            #Win.refresh
            #Win.getch
          end
        end
      end
    end
  end
end
