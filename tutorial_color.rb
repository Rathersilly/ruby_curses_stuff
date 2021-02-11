require 'curses'
include Curses

Curses.noecho # do not show typed keys
Curses.init_screen
Curses.stdscr.keypad(true) # enable arrow keys (required for pageup/down)
Curses.start_color
# Determines the colors in the 'attron' below
Curses.init_pair(COLOR_BLUE,COLOR_BLUE,COLOR_BLACK) 
Curses.init_pair(COLOR_RED,COLOR_RED,COLOR_BLACK)
stdscr.keypad = true
loop do

  case Curses.getch

  when Curses::KEY_DOWN, ?j
    Curses.clear
    Curses.setpos(0,0)
    # Use colors defined color_init
    Curses.attron(color_pair(COLOR_RED)|A_NORMAL){
      Curses.addstr("Page Up")
    }
  when Curses::KEY_UP, ?k
    Curses.clear
    Curses.setpos(0,0)
    Curses.attron(color_pair(COLOR_BLUE)|A_NORMAL){
      Curses.addstr("Page Down")
    }
  end
end

