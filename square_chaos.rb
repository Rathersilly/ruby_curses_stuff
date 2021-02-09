require 'curses'
require './chaos_fns'
include Curses


init_screen
curs_set(0)
cbreak
stdscr.keypad = true
noecho

maxlines = lines - 1
maxcols = cols - 1

ITERMAX = 10_000
choices = %w[sideways_skull square triangle]

y = [0, 0, maxlines, maxlines]
x = [0, maxcols, 0, maxcols]

setpos(0, 0)
addstr('0')
setpos(0, maxcols)
addstr('1')
setpos(maxlines, 0)
addstr('2')
setpos(maxlines, maxcols)
addstr('3')

yi = rand(maxlines)
xi = rand(maxcols)

menu_index = 0
loop do # menu loop
  fun = nil
  loop do # selection loop
    setpos(0, 0)
    addstr("select fractal function:\n\n")
    choices.each_with_index do |x, i|
      stdscr.attron(A_BOLD) if i == menu_index
      addstr("#{x}\n")
      stdscr.attroff(A_BOLD)
    end
    input = getch
    case input
    when ?j
      menu_index += 1 unless menu_index == choices.size - 1
    when KEY_DOWN
      menu_index += 1 unless menu_index == choices.size - 1
    when ?k
      menu_index -= 1 unless menu_index == 0
    when KEY_UP
      menu_index -= 1 unless menu_index == 0
    when 10
      fun = choices[menu_index]
    when ?q
      exit 0
    end
    refresh
    break if fun
  end
  cur_index = 0
  index = 0
  clear
  ITERMAX.times do |i|
    index = send(fun, index, cur_index)
    cur_index = index
    yi = (yi + y[index]) / 2
    xi = (xi + x[index]) / 2
    setpos(yi, xi)
    addstr('*')
    setpos(0, 0)
    addstr("yi: #{yi}, xi: #{xi}")
    refresh
    # sleep 0.2
  end

  
  getch
  clear
end
# stdscr.refresh
sleep 10

close_screen
