require 'curses'
require 'io/console'
include Curses


##############################
# Basic init
##############################
init_screen
noecho
curs_set(0)
Win = stdscr
Width = Win.maxx
Height = Win.maxy
Midx = Win.maxx/2
Midy = Win.maxy/2
Pi = Math::PI
Log = File.open("log", "w")

##############################
# keyboard stuff
##############################
cbreak
Win.timeout = 0
Win.keypad = true

def get_input
  key = getch
  case key
  when 'j'
    Win.gost 20,5,'j'
  when ?k 
    Win.gost 20,5,'k'
  end
  $stdin.iflush
  key
end

##############################
# Color stuff
##############################
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

##############################
# Map stuff
##############################
Mapwidth = Win.maxx - 90 
Map = Win.derwin(Height, Win.maxx - Mapwidth, 0,Mapwidth)
#Map = Win.derwin(Height, Width, (Win.maxy - Height)/2, (Win.maxx - Width)/2)
Map.box('|','-')

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
