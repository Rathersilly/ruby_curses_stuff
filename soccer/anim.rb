require 'curses'
require './art'
include Curses
init_screen
curs_set(0)
Rows = stdscr.maxy; Cols = stdscr.maxx
class Win
  attr_accessor :win, :pos, :dest, :tpos,:h, :w, :text
  def initialize(h = 10,w = 10,r = 0,c = 0)
    @h = h
    @w = w    
    @pos = [r,c]
    @win = stdscr.derwin(h,w,r,c)
    @dest = [0,0]
    @speed = 1
    @text = 'A'
    @tpos = [1,1]
  end
  def update
    #slope = (@dest[1] - @pos[1])/(@dest[0] - @pos[0])
    if @pos[0] < @dest[0]
      @pos[0] += @speed
    elsif @pos[0] > @dest[0]
      @pos[0] -= @speed
    end
    if @pos[1] < @dest[1]
      @pos[1] += @speed
    elsif @pos[1] > @dest[1]
      @pos[1] -= @speed
    end
    @win.move(@pos[0], @pos[1])
    @win.box('|', '-')
    @win.setpos(@tpos[0], @tpos[1])
    @win << @text
  end
  def draw
    @win.refresh
  end
end

#create windows
#
#each 
#loop
#update win
#draw win
iwins = WinArray.new
uwin = Win.new(10,10,0,0)
rwin = Win.new(10,10,0,Cols - 10)
gwin = Win.new(10,20,20,Cols/2 - 10 / 2)
uwin.text = "u"
rwin.text = "r"
gwin.text = "g"
iwins = [uwin, rwin, gwin]
#uwin.win = stdscr.derwin(10,10, rpos[0], rpos[1])
#rwin.win = stdscr.derwin(10,10, upos[0], upos[1])
#gwin.win = stdscr.derwin(10,60, gpos[0], gpos[1])
uwin.dest = [Rows/2 - uwin.h, Cols/2 - uwin.w]
rwin.dest = [Rows/2 - rwin.h, Cols/2 ]
gwin.dest = [20, Cols/2 - 10 / 2]
loop do
  #stdscr.clear
  iwins.each { |w| w.update }
  iwins.each { |w| w.win.refresh }
  iwins.each { |w| w.win.refresh }
  getch
  iwins.each { |w| w.win.clear }
  #stdscr.clear
  #sleep 0.4


  

end

