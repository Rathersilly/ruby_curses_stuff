require 'curses'
include Curses

init_screen
curs_set(0)
noecho

maxlines = lines - 1
maxcols = cols - 1

ITERMAX = 3000

#long iter
#int yi, xi
#int y[3], x[3]
#
y = [0, maxlines, 0]
x = [0, maxcols / 2, maxcols]


setpos(y[0], x[0])
addstr('0')
setpos(y[1], x[1])
addstr('1')
setpos(y[2], x[2])
addstr('2')

yi = rand(maxlines)
xi = rand(maxcols)
# check if point is inside triangle
# find distance from point to each vertex
# could also maybe set yi,xi to be inside triangle 
# automatically using different coord system?

setpos(yi, xi)
addstr('.')
ITERMAX.times do |i|
  index = rand(3)
  yi = (yi + y[index]) / 2
  xi = (xi + x[index]) / 2
  #next if xi > maxcols
  setpos(yi, xi)
  addstr('*')
  setpos(0,0)
  addstr("yi: #{yi}, xi: #{xi}")
  refresh
  #sleep 0.05
end

getch

refresh

close_screen
