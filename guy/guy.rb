require './guy_class'
require './guy_init'

Log = File.open("log", "w")


create_map
@guy = Guy.new(5,20)
@guy.dest = [10,15]

def draw_line(y0,x0,y1,x1)
  m = (y1.to_f - y0)/(x1.to_f - x0)
  Log.puts "in draw_line"
  Log.puts "#{y0}, #{x0}, #{y1}, #{x1}"


  dy = y1-y0
  dx = x1-x0
  dy = dy.to_f
  dx = dx.to_f
  derr =(dy/dx).abs
  err = 0.0
  y = y0
  x = x0

  #if dx.abs > dy.abs
      
  #works with pos slope
    (x0..x1).each do |x|
      Log.puts "y: #{y}, x: #{x}, m: #{m}"
      Win.setpos(12,5)
      Win << "y,x: #{y}, #{x}"
      Map.setpos(y,x)
      Map << "O"
      err = err + derr
      if err > 0.5
        if m < 0
          y = y - 1
        else
          y = y + 1
        end
        err = err - 1.0
      end
    end

end
x = 20
y = 3
loop do
  Map.clear

create_map


draw_line(Map.maxy - 1,10,y,x)
  y += 1
  y = 3 if y == Map.maxy
  #x = 10 if x > 30
  
  Map.refresh
  getch
  @guy.update


  draw
  Win.refresh
  Map.refresh

end


