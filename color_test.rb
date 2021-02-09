require 'curses'
include Curses

init_screen
start_color
begin
  (0..4).each do |x|
    (0..1).each do |y|


      init_pair(x, x, y)
      attron(color_pair(x))
      stdscr << "Hello there! #{x}, #{y}\n"
    end
  end
  refresh
  getch
      init_pair(1, 0, 1)
      attron(color_pair(1))
      stdscr << "HIHIHI"
      getch

  

ensure
  close_screen
end




  
