# Multiple window tutorial
# https://stac47.github.io/ruby/curses/tutorial/2014/01/21/ruby-and-curses-tutorial.html
require 'curses'

Curses.init_screen
Curses.curs_set(0)  # Invisible cursor

begin
  # Building a static window
  win1 = Curses::Window.new(Curses.lines / 2 - 1, Curses.cols / 2 - 1, 0, 0)
  win1.box("o", "o")
  win1.setpos(2, 2)
  win1.addstr("Hello")
  input = win1.getch
  if input == 'h' then
        win1.addstr("Left key")
  else
        win1.addstr("Other key")
  end
  win1.refresh
  # This bit will replace win1 because stdscr takes precedence (Curses.stdscr.getstr)
  #  win1 = Curses::Window.new(10, 20, 0, 0)
  #  win1.box("|", "-")
  #  win1.refresh
  #  input = Curses.getstr

  # But the win1 won't get overwritten if it is a subwin of stdscr:
  # win1 = Curses.stdscr.subwin(10, 20, 0, 0)
  # win1.box("|", "-")
  # win1.refresh
  # input = Curses.getstr

  # In this window, there will be an animation
  win2 = Curses::Window.new(Curses.lines / 2 - 1, Curses.cols / 2 - 1, 
                            Curses.lines / 2, Curses.cols / 2)
  win2.box("|", "-")
  win2.refresh
  2.upto(win2.maxx - 3) do |i|
    win2.setpos(win2.maxy / 2, i)
    win2 << "*"
    win2.refresh
    sleep 0.05 
  end

  # Clearing windows each in turn
  sleep 0.5 
  win1.clear
  win1.refresh
  win1.close
  sleep 0.5
  win2.clear
  win2.refresh
  win2.close
  sleep 0.5
rescue => ex
  Curses.close_screen
end
