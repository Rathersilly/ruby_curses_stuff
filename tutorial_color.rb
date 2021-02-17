require 'curses'
include Curses

noecho # do not show typed keys
init_screen
stdscr.keypad(true) # enable arrow keys (required for pageup/down)
start_color
# Determines the colors in the 'attron' below
init_pair(COLOR_BLUE,COLOR_BLUE,COLOR_BLACK) 
init_pair(COLOR_RED,COLOR_RED,COLOR_BLACK)
stdscr.keypad = true
win = stdscr.derwin(10, 10, 20, 40)
init_pair(100, 2, 4)
win.bkgd(color_pair(100))
win.refresh
loop do

  case getch

  when Curses::KEY_DOWN, ?j
    #clear
    setpos(0,0)
    # Use colors defined color_init
    attron(color_pair(COLOR_RED)|A_NORMAL){
      addstr("Page Up\n")
    }
  when Curses::KEY_UP, ?k
    #clear
    setpos(0,0)
    attron(color_pair(COLOR_BLUE)|A_NORMAL){
      addstr("Page Down\n")
    }
  end

  attron(color_pair(1) | A_BOLD) { addstr("A_BOLD\n") }
  attron(color_pair(1) | A_UNDERLINE) { addstr("A_UNDERLINE\n") }
  attron(color_pair(1) | A_DIM) { addstr("A_DIM\n") }
  attron(color_pair(1) | A_REVERSE) { addstr("A_REVERSE\n") }
  attron(color_pair(1) | A_BLINK) { addstr("A_BLINK\n") }
  attron(color_pair(1) | A_REVERSE) { addstr("A_REVERSE\n") }
  refresh
end

