require 'curses'
include Curses

init_screen
noecho
curs_set(0) # Invisible Cursor
HEIGHT = lines
WIDTH = cols


clear
stdscr.box('|', '-')
stdscr << 'Hello'
setpos(HEIGHT / 2, WIDTH / 2)
stdscr.addstr('Sup')
stdscr.refresh
getch
win = stdscr
#input = win.getch
#input = win.getstr
if input == Curses::Key::LEFT
  setpos(HEIGHT / 2, WIDTH / 2)
  stdscr.attron
  stdscr.addstr('Sup')
else
  win.addstr('Other key')
end
win << input
win.refresh
win.getch
close_screen
