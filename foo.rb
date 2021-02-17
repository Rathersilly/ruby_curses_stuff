require 'curses'
include Curses

init_screen

curs_set(0)
noecho

Bars = (1..8).each_with_object([]) { |i, a| a << 0x2580 + i }
Bars.map! { |x| [x].pack('U') }

h = 20
w = 40
Win = stdscr.derwin(h, w, 10, 10)
Win.box("|", "-")



def wipeout(h, w)
  (0..w - 1).each do |c|
    (0..h - 1).reverse_each do |r| 
      Bars.each do |x|
        Win.setpos(r, c)
        Win.addstr(x)
        Win.refresh
        #sleep 0.1
      end
      addstr(r.to_s)
      refresh
    end
  end
end

wipeout(h,w)






getch















