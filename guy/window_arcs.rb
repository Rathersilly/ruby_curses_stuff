class Curses::Window
  def draw_circle(y0,x0,r)
    # starting at 0, draw line and go upward
    # dy will be > dx
    a = 0.0
    x = x0 + r.to_f; y = y0.to_f
        Log.puts "x,x0 #{x}, #{x0}"
    err = 0.0

    count = 0
    xerr = 0.0
    yerr = 0.0
    coords = []
    xdir = -1
    ydir = -1
    count = 0
    loop do
      oldydir = ydir
      oldxdir = xdir

      dy = y - y0.to_f
      dx = x - x0.to_f
      if dx >= 0
        ydir = -1
      else
        ydir = 1
      end
      if dy <= 0
        xdir = -1
      else
        xdir = 1
      end
      #dx >= 0 ?  ydir = -1 : ydir = 1
      #dy <= 0 ?  xdir = -1 : xdir = 1
      
      Log.puts "loop"
      Log.puts "x,x0 #{x}, #{x0}"
      dy <= 0 ? dysign = -1 : dysign = 1
      dx <= 0 ? dxsign = -1 : dxsign = 1
      dya = dy.abs
      dxa = dx.abs
      if dx == 0.0
        Log.puts "hi1"
        Log.puts "x,x0 #{x}, #{x0}"
        xerr += 1
        yerr += 0
      elsif dy == 0.0
        Log.puts "hi2"
        yerr += 1
        xerr += 0
      elsif dxa >= dya
        yerr += 1
        xerr += dya/dxa
      elsif dya > dxa
        xerr += 1
        yerr += dxa/dya
      end
      Log.puts "yerr: #{yerr}, xerr: #{xerr}"
      Log.puts "dy: #{dy}, dx: #{dx}"
      Log.puts "----------"
      while yerr >= 1 || xerr >= 1
        if yerr >= 1
          y = y + 1 * ydir
          yerr -= 1
        end
        if xerr >= 1
          x = x + 1 * xdir
          xerr -= 1
        end
        coords << [y,x]
      end
      

      Win.setpos(20+ count,5)
      Win << "yerr: #{yerr}, xerr: #{xerr}"
      Log.puts "yerr: #{yerr}, xerr: #{xerr}"
      Log.puts "dy: #{dy}, dx: #{dx}"

      count += 1

      break if count >= 200

    end
    Log.puts coords
    c = 0
    coords.each do |a,b|
      setpos(a,b)
      self << "#{c}"
      c += 1
      c = 0 if c == 10
    end


  end
end
