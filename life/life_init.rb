
require 'curses'
include Curses
#Plant_image = "\u2698"
Plant_image = "P"
Green = 12
Yellow = 13
Cyan = 14
Magenta = 15
Red = 16
log = "log"
error = "error"
log = "/dev/null"
#error = "/dev/null"

Log = File.open(log, 'w')
$stderr = File.open(error,"w")
test_flag = false
if test_flag == false
  init_screen
  curs_set(0)
  noecho
  start_color
  init_pair(2,2,0)#COLOR_GREEN, COLOR GREEN, COLOR_BLACK)
  init_pair(Green, COLOR_GREEN, COLOR_BLACK)
  init_pair(3,3,0)#COLOR_GREEN, COLOR GREEN, COLOR_BLACK)
  init_pair(Yellow, COLOR_YELLOW, COLOR_BLACK)
  init_pair(Cyan, COLOR_CYAN, COLOR_BLACK)
  init_pair(Magenta, COLOR_MAGENTA, COLOR_BLACK)
  init_pair(Red, COLOR_RED, COLOR_BLACK)

  width = stdscr.maxx - 60
  Win = stdscr.derwin(stdscr.maxy - 4,width,2,(stdscr.maxx - width) /2)

  Win.box('x','x')
  Left = stdscr.derwin(30, 20, 2, Win.begx - 24)
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
10.times do 
  Plants << Plant.new(rand(1..Win.maxy - 2), rand(1..Win.maxx - 2))
end
Plants[0].max_age = 1000

herb = Herb.new(17, 20)
herb.max_age = 1000
herb.name = "Herby"
herb.sex = :male
herb.color = Cyan
herb2 = Herb.new(25, 20)
herb2.max_age = 1000
herb2.name = "Herbette"
herb2.sex = :female
herb2.color = Magenta
Herbs.concat [herb,herb2]

Msg = ""
Messages ={} 
Messages[:reports] = []
Messages[:herb_births] = 0
Messages[:herb_deaths] = 0

LForms = [Plants, Herbs, Preds]
State = %i|idle hungry scared horny dead|




