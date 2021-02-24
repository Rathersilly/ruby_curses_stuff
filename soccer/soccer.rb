# awesome fonts https://patorjk.com/software/taag/#p=display&v=0&f=ANSI%20Regular&t=U%20R%20Goalie
require 'curses'
require './art'
include Curses
#ok cool way to do the intro might be to have a win_sprite class, which could
#be moved just like a sprite.  this would allow uncovering of the field

init_screen
curs_set(0)
noecho
start_color
Win = stdscr
Rows = Win.maxy; Cols = Win.maxx

def play_intro
end

def draw_field
  i = 10
  Field_a.each do |row|
    setpos(i,20)
    # stdscr.addstr("#{Rows}, #{Cols}")
    stdscr.addstr(row.join)
    i += 1
  end
end

play_intro
upos = [10,Cols - 10]
umaxpos = [10, Cols / 2 - 12]
rpos = [10,3]
rmaxpos = [10, Cols / 2 + 2]
gpos = [Rows - 10, Cols/2 - Art_ga[0].size / 2]
uwin = stdscr.derwin(10,10, upos[0], upos[1])
rwin = stdscr.derwin(10,10, rpos[0], rpos[1])
gwin = stdscr.derwin(10,60, gpos[0], gpos[1])



count = 0
loop do
  uwin.clear
  rwin.clear
  gwin.clear
  Win.clear
  rwin.move(rpos[0], rpos[1])
  rwin.move(rmaxpos[0], rmaxpos[1]) if rpos[1] > rmaxpos[1]
  uwin.move(upos[0], upos[1])
  uwin.move(umaxpos[0], umaxpos[1]) if upos[1] < umaxpos[1]
  gwin.move(gpos[0], gpos[1]) unless gpos[0] < Rows / 2
  Win.refresh
  uwin  << Art_u
  rwin  << Art_r
  gwin  << Art_g
  stdscr.setpos(0,0)
  stdscr.addstr("#{count}, #{}")
  #uwin.box('|','-')
  #rwin.box('|','-')
  stdscr.refresh
  uwin.refresh
  rwin.refresh
  gwin.refresh
  #getch
  sleep 0.05
  upos[1] -= 4
  rpos[1] += 4
  gpos[0] -= 1
  count += 1
  break if count > 25

end
getch
uwin.move(umaxpos[0], umaxpos[1])
rwin.move(rmaxpos[0], rmaxpos[1])
upos[0] = umaxpos[0]; upos[1] = umaxpos[1]
rpos[0] = rmaxpos[0]; rpos[1] = rmaxpos[1]
draw_field
refresh


loop do
  uwin.clear
  rwin.clear
  gwin.clear
  Win.clear
  draw_field
  rwin.move(rpos[0], rpos[1])# unless rpos[1] > Cols / 2 + 4hhhhhh
  uwin.move(upos[0], upos[1])# unless upos[1] < Cols / 2 - Art_ua[0].size - 4
  gwin.move(gpos[0], gpos[1])# unless gpos[0] < Rows / 2
  Win.refresh
  uwin  << Art_u
  rwin  << Art_r
  gwin  << Art_g
  stdscr.setpos(0,0)
  stdscr.addstr("#{count}, #{}")
  #uwin.box('|','-')
  #rwin.box('|','-')
  stdscr.refresh
  uwin.refresh
  rwin.refresh
  gwin.refresh
  #getch
  sleep 0.05
  upos[1] -= 2
  rpos[1] += 2
  gpos[0] -= 1
  count += 1
  break if count > 60

end



