require "curses"
include Curses
init_screen
noecho
curs_set(0)
#start_color
#init_pair(1, 1, 0)
Win = stdscr

Height= stdscr.maxy
Width= stdscr.maxx

class Thing
  def initialize
    @shape = "X"
    @dgrow = 0.5

    
    
  end
  def grow

  end
end
loop do

end

