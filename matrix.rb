require 'curses'
include Curses

init_screen
start_color
curs_set(0)
COLOR = 2 # green
INTERVAL = 0.3

init_pair(1, COLOR, 0) # set purple on black

class Codeline
  attr_accessor :x, :y, :ary

  def initialize
    @ary = "Hello there".split('')
    @x = 20
    @y = 0
  end
end

codeline = Codeline.new

begin
  win = stdscr
  win.attron(color_pair(1))
  loop do
    codeline.ary.each_index do |i|
      x = codeline.x ; y = codeline.y
      break if y - i < 0
      win.setpos(codeline.y-i, codeline.x)
      win << codeline.ary[i]
    end
    codeline.y += 1
    sleep INTERVAL

    win.refresh
    



  end

end


