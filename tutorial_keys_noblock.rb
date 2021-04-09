require 'curses'
require 'io/console'
include Curses

init_screen
win = stdscr
curs_set(0) # 0=invis, 1=vis, 2=veryvis
# cbreak # disables line buffering - turn off w/ nocbreak
# raw # disables line buf + ctrl keys - turn off w/ nocbreak

count = 1

# Window#timeout info:
# default is blocking
# If delay is negative, blocking read is used
# (i.e., waits indefinitely for input).

# If delay is zero, then non-blocking read is used
# (i.e., read returns ERR if no input is waiting).

# If delay is positive, then read blocks for delay
# milliseconds, and returns ERR if there is still no input.

# win.timeout = 0
# however, spamming keys will make it go fast if timeout
# is long
# win.timeout = 1000
begin
  loop do
    # win.clear
    win.setpos((lines / 2 - 1), (cols / 2 - 1))
    win << 'Press something '
    win.attron(A_BOLD) { win << count.to_s }
    win.refresh
    str = win.getch # get character, wait for enter
    # str = win.getstr      # get line

    case str
    # when 'j'
    when 'q'
      exit 0
    # else
    when /\w/
      win.clear
      msg = "YOU HAVE PRESSED #{str}"
      win.setpos((lines / 2 - 1 + 2), (cols / 2 - 1)) # - msg.size / 2)
      win << msg
      win.refresh
    else
      win.setpos((lines / 2 - 1 + 2), (cols / 2 - 1)) # - msg.size / 2)
      win << ' ' * 20
      win.refresh
    end
    # flush stdin before sleeping
    $stdin.iflush
    # sleep 0.3
    count += 1
  end
ensure
  close_screen
end
