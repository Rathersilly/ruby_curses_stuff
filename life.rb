require 'curses'
require './life_plant'
require './life_herb'
require './life_helpers'
include Curses

init_screen
curs_set(0)
noecho
start_color
Green = 12
Yellow = 13
init_pair(2,2,0)#COLOR_GREEN, COLOR GREEN, COLOR_BLACK)
init_pair(Green, COLOR_GREEN, COLOR_BLACK)
init_pair(3,3,0)#COLOR_GREEN, COLOR GREEN, COLOR_BLACK)
init_pair(Yellow, COLOR_YELLOW, COLOR_BLACK)
Log = File.open("log", 'w')

width = stdscr.maxx - 60
Win = stdscr.derwin(stdscr.maxy - 4,width,2,(stdscr.maxx - width) /2)

Win.box('x','x')
Left = stdscr.derwin(20, 20, 2, Win.begx - 24)
Left.box('x','x')
Win.setpos(4,4)
Win << "Hello"
Win << "\u2698"
Win.refresh
Left.refresh
getch

Plants = []
Newplants = []
Newherbs = []
Herbs = []
Preds = []
Plants << Plant.new(20,20)
Plants[0].max_age = 1000
Herbs << Herb.new(25, 20)
LForms = [Plants, Herbs, Preds]
State = %i|idle hungry scared|
  
Win.refresh
@day = 0
@watched = Herbs[0]
Msg = ""
loop do
  update_plants
  update_herbs

  purge_plants
  purge_herbs
  draw_things

  daily_report

  Win.refresh
  Left.refresh

  day_cleanup

  getch
  #sleep 0.1
 #  Left.setpos(1,0)
 #  Left.clrtoeol
 #  Left.setpos(2,0)
 #  Left.clrtoeol
  Left.clear

end



Log.close
