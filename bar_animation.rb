require 'curses'
include Curses

init_screen
curs_set(0)
noecho

bars = (1..8).each_with_object([]) { |i, a| a << 0x2580 + i }
bars.map! { |x| [x].pack('U') }

i = 0
rows = 0
loop do
  if i == bars.size
    i = 0
    rows += 1
  end
  rows.times do |i|
    setpos(20 - i, 10)
    addstr("\u2588")
  end
   
  setpos(20 - rows,10)
  addstr(bars[i])
  #addstr(rows.to_s)
  #addstr(i.to_s)
  #addstr(bars.size.to_s)
  refresh
  i += 1
  # getch
  sleep 0.01
end
class Turtle
  attr_accessor :x, :y
  
  def initialize
    @x = 5
    @y = 5
  end
end

def w
