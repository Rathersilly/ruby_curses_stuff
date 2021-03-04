require 'curses'
include Curses
include Math

init_screen
noecho
curs_set(0)
start_color
Win = stdscr


mid = [Win.maxy/2, Win.maxx/2]
y = mid[0]
x = mid[1]
sy = mid[0]
sx = mid[1]
radius = 15.0
r = radius
r2 = radius ** 2 
#dt = dtheta = angle step
dt = 0
Win.setpos(mid[0], mid[1])
Win << "\u25CF"
Win.refresh
theta = 0

i = 0
loop do
  break
  newy = y + radius * sin(theta)
  newx = x + radius * cos(theta)
  Win.setpos(0,0)
  Win << "newy: #{newy}, newx: #{newx}, theta: #{theta}"
  Win.setpos(newy, newx)
  #Win << i.to_s
  Win << "\u25CF"
  getch
  i += 1
  theta += Math::PI / 32
end
i = 0
theta = 0

loop do
  break
  dy = radius * sin(theta)
  dx = radius * cos(theta)
  # so we know new point is newy, newx
  # based on symmetry, we also know other points
  # newy, -newx; new
  # mid + 
  newpts = [[y+dy, x+dx],[y-dy, x+dx],[y+dy, x-dx],[y-dy, x-dx]]
  newpts.each do |pos|
    Win.setpos(pos[0], pos[1])
    Win << i.to_s
  end
  refresh
  getch
  i += 1
  theta += Math::PI / 32
end

dy = 0
dx = 0
#first point is 0,r
y = 0
x = 0 + radius
dy = 0
dx = 0
newy = mid[0] + y
newx = mid[1] + x
Win.setpos(newy, newx)
Win << i.to_s
Win.setpos(0,0)
Win << "newy: #{newy}, newx: #{newx}"
spt = [sy + r, sx], [sy - r, sx], [sy, sx + r], [sy, sx - r]

loop do
  #start at theta = 0 go clockwise.  y is fast direction
  #each iteration, increase y by 1
  #next pixel is either (y+1, x+0) or (y+1, x+1)
  y += 1
  dy += 1
  
  fun = y**2 + (x+0.5)**2 - r2
  if fun >= 1 
    x -=1   
    dx -= 1
  end
  Win.setpos(0,0)
  Win << "y: #{y}, x: #{x}, fun: #{fun}"
  spt.each do |pt|
    Win.setpos(pt[0] + dy, pt[1] + dx)
    Win << i.to_s
  end
  Win.setpos(1,0)
  Win << "newy: #{mid[0] + y}, newx: #{mid[1] + x}, fun: #{fun}"

  Win.setpos(mid[0] + y, mid[1] + x)
  Win << i.to_s
  
  
  refresh
  getch
  i += 1



end


