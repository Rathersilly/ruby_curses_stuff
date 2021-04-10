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
White = COLOR_WHITE
Colors = [Green,Yellow,Cyan,Magenta,Red].cycle.to_enum
init_pair(Green, COLOR_GREEN, COLOR_BLACK)
init_pair(Yellow, COLOR_YELLOW, COLOR_BLACK)
init_pair(Cyan, COLOR_CYAN, COLOR_BLACK)
init_pair(Magenta, COLOR_MAGENTA, COLOR_BLACK)
init_pair(Red, COLOR_RED, COLOR_BLACK)
init_pair(White, COLOR_WHITE, COLOR_BLACK)
@selection = 0
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
Tests = []
File.open("shape_test.rb") do |f|
  f.each_line do |line|
    if line.start_with?("def test_")
      m = line.match(/(test_[\w_]+)/)
      Tests << $1.to_sym
      #Win.gost 20,10,$1
      #Win.getch
    end
  end
end

def get_input
  key = getch
  case key
  when 'j'
    #when ?j 
    Win.gost 20,5,'j'
  when ?k 
    Win.gost 20,5,'k'
  end
  $stdin.iflush
  key
end

def do_menu(input = nil)
  y =5 
  x = 10
  # the to_s is necessary - Curses::KEY_ENTER doesnt
  # seem to work
  case input.to_s
  when ?k           # ?k = 'k' - char literal operator
    @selection -= 1
    @selection = Tests.size - 1 if @selection < 0
  when ?j
    @selection += 1
    @selection = 0 if @selection == Tests.size
  when '10'
    send(Tests[@selection])
  when 97.chr       # this works just lika 'a
    @selection = 0

  end
  Win.gost y - 3,x, "Enter: ", KEY_ENTER
  Win.gost y - 2,x, "Tests available:"
  #Win.gost y - 1,x, "Selection: ", @selection.to_s
  Tests.each_with_index do |test, i|
    if i == @selection
      Win.attron(color_pair(Green))
    else
      Win.attron(color_pair(White))
    end
    Win.gost y,x,test.to_s
    Win.attron(color_pair(White))
    y += 1
  end
  Win.refresh
end


def test_draw_8ths
  loop do
    c = Circle.new(Midy,Midx,16)
    Win.attach(c)
    c.color = Cyan
    c.draw_8ths
    Win.refresh
    sleep 0.1
  end
end




do_menu
loop do
  #do_menu(get_input)
  test_draw_8ths
  sleep 0.2


  #send tests.first
  #c.draw
  #test_circle_nls
  #test_squish
  #test_squish_input
  #test_line
  #test_vert
  #test_around
  #test_left
end

