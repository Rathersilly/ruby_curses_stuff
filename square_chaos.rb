require 'curses'
include Curses

def sideways_skull(index, cur_index)
  # spooky skulls! wow
  index = rand(4)
  while cur_index - index == 1 || cur_index - index == -3
    index = rand(4)
    setpos(0,30)
    addstr("index: #{index}")
    refresh
    #sleep 0.3
  end
  index
end
choices = %w[sideways_skull]#, "triangle"]


init_screen
curs_set(0)
cbreak
stdscr.keypad(true)

noecho

maxlines = lines - 1
maxcols = cols - 1

ITERMAX = 5000

y = [0, 0, maxlines, maxlines]
x = [0, maxcols, 0, maxcols]

setpos(0,0)
addstr('0')
setpos(0,maxcols)
addstr('1')
setpos(maxlines, 0)
addstr('2')
setpos(maxlines, maxcols)
addstr('3')


yi = rand(maxlines)
xi = rand(maxcols)

menu_index = 0
fun = nil
loop do # menu loop
  loop do
    setpos(0,0)
    addstr("select fractal function:\n\n")
    choices.each_with_index do |x, i|
      stdscr.attron(A_BOLD) if i == menu_index
      addstr("#{x}\n")
      stdscr.attroff(A_BOLD)
    end
    input = getch.to_s  # the to_s is important - otherwise
                        # enter is integer  
    addstr(input.class.to_s)
    case input
    when 'j'
      menu_index += 1 unless menu_index == choices.size - 1
    when 'k'
      menu_index -= 1 unless menu_index == 0
    when '10'
      fun = choices[menu_index]

      addstr("HIHIHI")
      
    end
    refresh
    getch
    break if fun

  end
  cur_index = 0
  index = 0
  ITERMAX.times do |i|

    #index = public_send(fun, index, cur_index)
    index = send(fun, index, cur_index)
    #index = rand(3)# will make s triangle!

    # square fractal
    #while index == cur_index
      #index = rand(4)
    #end
    cur_index = index
    yi = (yi + y[index]) / 2
    xi = (xi + x[index]) / 2
    #next if xi > maxcols
    setpos(yi, xi)
    addstr('*') 
    setpos(0,0)
    addstr("yi: #{yi}, xi: #{xi}")
    refresh
    #sleep 0.2
  end

  getch
end
#stdscr.refresh
sleep 10



close_screen
