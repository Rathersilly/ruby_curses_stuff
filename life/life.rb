require 'curses'
require './life_helpers'
require './life_plant'
require './life_herb'
require './life_init'
include Curses
test_flag = false
test_flag = true unless  __FILE__ == $0
quit_flag = false
  
@day = 0
@watched = Herbs[0]
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
