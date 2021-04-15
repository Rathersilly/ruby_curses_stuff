def demo_menu(input = nil, delay = 0)
  y =5 
  x = 10
  # the to_s is necessary - Curses::KEY_ENTER doesnt
  # seem to work
  case input.to_s
  when ?k           # ?k = 'k' - char literal operator
    @selection -= 1
    @selection = @demos.size - 1 if @selection < 0
  when ?j
    @selection += 1
    @selection = 0 if @selection == @demos.size
  when '10'
    @demo.send(@demos[@selection])
  when 97.chr       # this works just lika 'a
    @selection = 0
  when ?q
    exit
  end
  Win.gost y - 4,x, "Enter: ", KEY_ENTER
  Win.gost y - 3,x, "demos available:"
  Win.gost y - 2,x, "(press q to escape demo)"
  #Win.gost y - 1,x, "Selection: ", @selection.to_s
  @demos.each_with_index do |test, i|
    if i == @selection
      Win.attron(color_pair(Green))
    else
      Win.attron(color_pair(White))
    end
    Win.gost y,x,test.to_s
    Win.attron(color_pair(White))
    y += 1
  end
  Win.refresh
end

