require 'curses'
require './life_helpers'
require './life_plant'
require './life_herb'
include Curses
test_flag = false
test_flag = true unless  __FILE__ == $0
quit_flag = false
#Plant_image = "\u2698"
Plant_image = "P"
Green = 12
Yellow = 13
log = "log"
error = "error"
log = "/dev/null"
error = "/dev/null"

Log = File.open(log, 'w')
$stderr = File.open(error,"w")
if test_flag == false
  init_screen
  curs_set(0)
  noecho
  start_color
  init_pair(2,2,0)#COLOR_GREEN, COLOR GREEN, COLOR_BLACK)
  init_pair(Green, COLOR_GREEN, COLOR_BLACK)
  init_pair(3,3,0)#COLOR_GREEN, COLOR GREEN, COLOR_BLACK)
  init_pair(Yellow, COLOR_YELLOW, COLOR_BLACK)

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
end

Plants = []
Newplants = []
Newherbs = []
OldPos = []
Herbs = []
Preds = []
Plants << Plant.new(20,20)
Plants[0].max_age = 1000
herb = Herb.new(17, 20)
herb.max_age = 1000
herb.name = "Herby"
herb.sex = :male
herb2 = Herb.new(25, 20)
herb2.max_age = 1000
herb2.name = "Herbette"
herb2.sex = :female
Herbs.concat [herb,herb2]

LForms = [Plants, Herbs, Preds]
State = %i|idle hungry scared horny dead|
  
@day = 0
@watched = Herbs[0]
Msg = ""
loop do
  break if test_flag == true
  break if quit_flag == true

  update_things
  purge_things
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
