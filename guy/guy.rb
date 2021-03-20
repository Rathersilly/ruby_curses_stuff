require './guy_class'
require './guy_init'

Log = File.open("log", "w")


create_map
@guy = Guy.new(5,20)
@guy.dest = [10,15]

def draw_line(y0,x0,y1,x1)
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
      Map << "O"
      err = err - 1.0
    end
      
  end

end
x = 30
y = 2
loop do
  Map.clear

  create_map

  #draw_line(15,25,y,x)
  #draw_line(Midy,Midx,y,Midx + x)
  #draw_line(Midy,Midx,y,Midx - x)
  draw_line(Midy,Midx,y,Midx - x)
  x -= 1
  Win.setpos(20,5)
  Win << "end1: #{y}, #{Midx+x}"
  Win.setpos(21,5)
  Win << "end2: #{y}, #{Midx-x}"
  #y += 1
  #y = 3 if y == Map.maxy
  #x = 10 if x > 30
  
  Map.refresh
  getch
  @guy.update


  draw
  Win.refresh
  Map.refresh

end


