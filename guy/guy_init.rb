require 'curses'
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
init_screen
noecho
curs_set(0)
Win = stdscr
width = 40
height = 20
Map = Win.derwin(height, width, (Win.maxy - height)/2, (Win.maxx - width)/2)
Map.box('|','-')


Map.setpos(1,1)
Map << "hey"
Map.refresh
