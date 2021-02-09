
require 'curses'
include Curses

init_screen
win = stdscr
curs_set(1) # 0=invis, 1=vis, 2=veryvis
cbreak # disables line buffering - turn off with nocbreak



count = 0
begin
  loop do


      win.setpos((lines / 2 - 1), (cols / 2 - 1))
      # win.attron(A_BOLD) if count.even?
      win.attron(A_REVERSE) if count.even?
      win << "HELLO #{count}"
      # win.attroff(A_BOLD) 
      win.attroff(A_REVERSE) 

      win.refresh
      sleep 0.3
      count += 1


  end
ensure
close_screen
end
