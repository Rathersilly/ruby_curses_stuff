
def sideways_skull(index, cur_index)
  # spooky skulls! wow
  index = rand(4)
  while cur_index - index == 1 || cur_index - index == -3
    index = rand(4)
    setpos(0, 30)
    addstr("index: #{index}")
    refresh
    # sleep 0.3
  end
  index
end


def square(index, cur_index)
    # square fractal
  
  while index == cur_index
    index = rand(4)
  end
  index
end

def triangle(index, cur_index)
  index = rand(3)# will make s triangle!
end

def menu_loop
  fun = nil
  loop do # selection loop
    setpos(0, 0)
    addstr("select fractal function:\n\n")
    CHOICES.each_with_index do |x, i|
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
  fun
end
