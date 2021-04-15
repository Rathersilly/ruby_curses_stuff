# oh man, this is repository of bad ideas

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
  # get line to farthest x

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

def pie4(cy,cx,a0,a1,r,step=Math::PI/32)
  wedge(cy,cx,a0,a1,r,step=Math::PI/32)
  # get corners m,n
  my = (r* Math.sin(a0) + cy).round
  mx = (r* Math.cos(a0) + cx).round
  ny = (r* Math.sin(a1) + cy).round
  nx = (r* Math.cos(a1) + cx).round
  otherline = draw_line(cy,cx,ny,nx)#,dest: [])
  # get line to farthest x
  linecord = draw_line(cy,cx,my,mx)#,dest: [])
  otherline = draw_line(cy,cx,ny,nx)#,dest: [])
  if mx < nx
    linecord,otherline = otherline,linecord
  end
  #end

  #if my < ny
  linecord.each do |y,x|
    #while true
    setpos(y,x)
    next if otherline.include? [y,x]
    gost(28,5,linecord.select{|a,b| a == y})
    gost(30,5,otherline.select{|a,b| a == y})
    (1..8).each do |n|

      setpos(y+n,x)
      gost(32,5,inch)
      setpos(y+n,x)
      break if inch == 'X'.ord || otherline.include?([y+n,x])
      self << "*"
      #getch
    end
    (1..8).each do |n|

      setpos(y,x+n)
      gost(32,5,inch)
      setpos(y,x+n)
      break if inch == 'X'.ord || otherline.include?([y,x+n])
      self << "*"
      #getch
    end
  end
end

