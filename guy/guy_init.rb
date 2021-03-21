require 'curses'
require './window_lines'
require './window_arcs'
include Curses

def create_map
  pillars = [[5,5],[5,10],[10,5],[10,10]]
  Map.setpos(0,0)
  Map << "X" * Map.maxx
  Map.maxy.times do |y|
    Map.setpos(y,0)
    Map << "X"
    Map.setpos(y,Map.maxx-1)
    Map << "X"
  end
  Map.setpos(Map.maxy-1,0)
  Map << "X" * Map.maxx

  pillars.each do |coord|
    Map.setpos(coord[0],coord[1])
    Map << "X"
  end
    
  
end

def update
end
def draw 
  Map.setpos(@guy.y,@guy.x)
  Map << "@"


end
Log = File.open("log", "w")
init_screen
noecho
curs_set(0)
Win = stdscr
Width = 90
Height = Win.maxy
Midx = Width/2
Midy = Height/2

Map = Win.derwin(Height, Width, 0,Win.maxx-Width)
#Map = Win.derwin(Height, Width, (Win.maxy - Height)/2, (Win.maxx - Width)/2)
Map.box('|','-')


Map.setpos(1,1)
Map << "hey"
Map.refresh
