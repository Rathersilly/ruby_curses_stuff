require 'curses'  # =>
require './art'
include Curses
init_screen
curs_set(0)
noecho
Rows = stdscr.maxy; Cols = stdscr.maxx
class Win
  attr_accessor :win, :pos, :dest, :tpos, :h, :w, :text, :speed

  def initialize(h = 10, w = 10, r = 0, c = 0, speed = 1.0)
    @h = h
    @w = w
    @pos = [r, c]
    @win = stdscr.derwin(h, w, r, c)
    @dest = [0.0, 0.0]
    @speed = speed.to_f
    @text = 'A'
    @tpos = [1.0, 1.0]
  end

  def update
    # want to move x and y equal % of dist to dest xy
    # thats not quite right though
    # if ystep is 0, move x speed units/turn and vice versa
    # the greater step determines the speed that is 1
    # the lesser step goes by a fraction

    ystep = @dest[0] - @pos[0]
    xstep = @dest[1] - @pos[1]
    #slope = ystep/xstep rescue nil
    # should use slope for determining stuff
    yabs = ystep.abs.to_f
    xabs = xstep.abs.to_f
    # need to move right and down
    #stdscr << "#{yabs/xabs} #{yabs.class}"
    @pos[1] = @dest[1] if xstep < 0
    @pos[0] = @dest[0] if ystep < 1
    if xabs > yabs && xstep > 0
      @pos[1] += @speed # unless ystep == 0
      @pos[0] += @speed * yabs/xabs
      stdscr.setpos(0,0)
      #stdscr << "#{yabs/xabs} #{yabs.class}"
    # need to move left and down
    elsif xabs > yabs && xstep < 0
      @pos[1] -= @speed # unless ystep == 0
      @pos[0] += @speed * yabs/xabs
      stdscr.setpos(0,0)
      #stdscr << "#{yabs/xabs} #{yabs.class}"
    # need to move up 
    elsif yabs > xabs && xabs == 0
      @pos[0] -= @speed
      stdscr.setpos(0,0)
      #stdscr << "#{yabs/xabs} #{yabs.class}"
    end
    @pos[1] = @dest[1] if xstep < 1
    @pos[0] = @dest[0] if ystep < 1

    
    # want whole thing to take step * speed turns

    # if on same row, speed should be 0
    # (@dest[0] - @pos[0]) * step
    # slope = (@dest[1] - @pos[1])/(@dest[0] - @pos[0])
    # if ystep > 0
    #@pos[0] += ystep / @speed # unless ystep == 0
    #ystep = @dest[0] - @pos[0]
    #@pos[0] = @dest[0] if ystep <= ystep / @speed
    # elsif ystep < 0
    # @pos[0] = @speed * ystep
    # end
    # if @pos[1] < @dest[1]
    # @pos[1] += @speed
    # elsif @pos[1] > @dest[1]
    # @pos[1] -= @speed
    # end
    @win.move(@pos[0], @pos[1])
    @win.box('|', '-')
    @win.setpos(@tpos[0], @tpos[1])
    @win << "#{@text}, ystep: #{ystep}, xstep: #{xstep}, abs_slope: #{yabs/xabs} "
  end

  def draw
    @win.refresh
  end
end

# create windows
#
# each
# loop
# update win
# draw win
uwin = Win.new(10, 10, 0, 0,)
rwin = Win.new(10, 10, 0, Cols - 10,)
gwin = Win.new(10, 20, Rows - 10, Cols / 2 - 20 / 2, 0.3)
uwin.text = 'u'
rwin.text = 'r'
gwin.text = 'g'
iwins = [uwin, rwin, gwin]
# uwin.win = stdscr.derwin(10,10, rpos[0], rpos[1])
# rwin.win = stdscr.derwin(10,10, upos[0], upos[1])
# gwin.win = stdscr.derwin(10,60, gpos[0], gpos[1])
uwin.dest = [Rows / 2 - uwin.h, Cols / 2 - uwin.w]
rwin.dest = [Rows / 2 - rwin.h, Cols / 2]
gwin.dest = [20, Cols / 2 - 20 / 2]
loop do
  # stdscr.clear
  iwins.each { |w| w.update }
  iwins.each { |w| w.win.refresh }
  iwins.each { |w| w.win.refresh }
  getch
  iwins.each { |w| w.win.clear }
  # stdscr.clear
  # sleep 0.4
end
