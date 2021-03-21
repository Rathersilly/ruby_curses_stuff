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
    loop do
      count += 1
      dy = y - y0.to_f
      dx = x - x0.to_f
      Log.puts "loop"
        Log.puts "x,x0 #{x}, #{x0}"
      dy < 0 ? dysign = -1 : dysign = 1
      dx < 0 ? dxsign = -1 : dxsign = 1
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
          y = y - 1 
          yerr -= 1
        end
        if xerr >= 1
          x = x - 1
          xerr -= 1
        end
        coords << [y,x]
      end
      

      Win.setpos(20+ count,5)
      Win << "yerr: #{yerr}, xerr: #{xerr}"
      Log.puts "yerr: #{yerr}, xerr: #{xerr}"
      Log.puts "dy: #{dy}, dx: #{dx}"


      break if count >= 100

    end
    Log.puts coords
    coords.each do |a,b|
      setpos(a,b)
      self << "&"
    end


  end
end
