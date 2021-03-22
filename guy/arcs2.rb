class Curses::Window
  # this looks too square!
  def draw_circle2(y0,x0,r)

    x = r.to_f
    y = 0.0

    coords = []
    err = 0.0
    xerr = 0.0
    loop do
      
      dy = r - y    # starts at r 
      dx = r - x    # starts at 0
      
      dya = dy.abs
      dxa = dx.abs
      break if dxa > dya
      # xerr goes from 0 to 1 at 90deg
      xerr = (r - dya) / r
      err += xerr
      
      

      Log.puts "err: #{err}, xerr: #{xerr}"
      Log.puts "dy: #{dy}, dx: #{dx}"
      Win.setpos(19,5)
      Win << "y: #{y}, x: #{x}"
      Win.setpos(20,5)
      Win << "dy: #{dy}, dx: #{dx}"
      Win.setpos(21,5)
      Win << "err: #{err}, xerr: #{xerr}"
      Win.getch
      y += 1
      if err > 1
        x -= 1
        err -= 1
      end
      coords << [y,x] 
      self.setpos(y0 + y, x0 + x)
      self << "#"
      self.refresh

    end
    c2 = []
    coords.each do |y,x|
      c2 << [-y,-x]
      c2 << [-y,x]
      c2 << [y,-x]
      c2 << [x,y]
      c2 << [-x,-y]
      c2 << [-x,y]
      c2 << [x,-y]
    end
    
    coords += c2
    coords << [0,r]
    coords << [0,-r]
    coords << [r,0]
    coords << [-r,0]
    Log.puts "#{coords.inspect}"


    Log.puts "radius"
    coords.each do |y,x|
      rad = Math.sqrt(y**2 + x ** 2)
      Log.print rad.to_s
      Log.print " "
    end



    c = 0
      coords.each do |a,b|
        self.attron(A_BOLD)
        setpos(y0 + a, x0 + b)
        self << "#{c}"
        c += 1
        c = 0 if c == 10
      end
      self.attroff(A_BOLD)
  end
end

