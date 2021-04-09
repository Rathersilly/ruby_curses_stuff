# this is second try at graphics library
# major refactor after reading stroustrup
require './guy_init'
require './shape'
require './window_monkey'
require './shape_test'

start_color
Green = 12
Yellow = 13
Cyan = 14
Magenta = 15
Red = 16
init_pair(Yellow, COLOR_YELLOW, COLOR_BLACK)
init_pair(Cyan, COLOR_CYAN, COLOR_BLACK)
init_pair(Magenta, COLOR_MAGENTA, COLOR_BLACK)
init_pair(Red, COLOR_RED, COLOR_BLACK)
Midx = Win.maxx/2
Midy = Win.maxy/2

c = Circle.new(20,40,10)
Win.attach(c)
ln = Line.new(20,20,10,30)
Win.attach(ln)
ln.color = Yellow
begin
  ln.draw
rescue => e
  Win.gost 10,10, e.message
  Win.gost 12,10, e.backtrace
  Win.gost 14,10, e.backtrace.inspect
  Win.getch
end



Win.getch

loop do
  #c.draw
  #test_circle_nls
  test_squish
  #test_line
  #test_vert
  #test_around
  #test_left
end

