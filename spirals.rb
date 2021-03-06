require "curses"
include Curses
init_screen
noecho
curs_set(0)
#start_color
#init_pair(1, 1, 0)
Win = stdscr

Height= stdscr.maxy
Width= stdscr.maxx
class Fire
  attr_accessor :y, :x
  def initialize(y=Height/2,x=Width/2)
    @y=y
    @x=x
    @log = File.open('log', 'w')
  end
  def update
    a = []
    s = 1
    loop do
      (-s..s).each do |i|
        (-s..s).each do |j|
          next if i.abs < s && j.abs < s
          a << [@y+i,@x+j]

        end
      end
      s += 1
      break if s > 4
    end
    a
  end
  def sq_spiral
    a = []
    dir = [:r,:d,:l,:u].cycle.to_enum
    s = 0
    loop do
      sflag = false
      s += 1
      ty = @y - s
      tx = @x - s
      a << [ty,tx]
      td = dir.first
      loop do
        @log.puts "td: #{td}, ty: #{ty}, tx: #{tx}"
        case td
        when :r
          if tx == @x + s
            td = dir.next
          else
            tx += 1
            a << [ty,tx]
          end
        when :d
          if ty == @y + s
            td = dir.next
          else
            ty += 1
            a << [ty,tx]
          end
        when :l
          if tx == @x - s
            td = dir.next
          else
            tx -= 1
            a << [ty,tx]
          end
        when :u
          if ty == @y - s
            sflag = true
            td = dir.next
          else
            ty -= 1
            a << [ty,tx]
          end
        end
      break if sflag == true
      end
      break if s > 6
    end
    a
  end

end
fire = Fire.new
#a = fire.update
#e = fire.update.to_enum
#e = [].to_enum
sq_spiral = fire.sq_spiral.to_enum

loop do

  Win.setpos(fire.y,fire.x)
  Win << "X"
  #Win.setpos(0,0)
  #Win << a.to_s
  pos = sq_spiral.next
  y = pos[0]
  x = pos[1]
  Win.setpos(y,x)
  Win << "!"

  #pos = e.next
  y = pos[0]
  x = pos[1]
  Win.setpos(y,x)
  #Win << "X"
  
  Win.refresh
  sleep 0.1
  




end



