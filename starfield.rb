require "curses"
include Curses


init_screen
noecho
curs_set(0)
#color_stajI#
#init_pair(1, 1, 0)

Height= stdscr.maxy
Width= stdscr.maxx

class Star
  attr_accessor :x, :y, :vx, :vy, :shape

  def initialize
    @x = rand(Width).to_f
    @y = rand(Height).to_f
    @x += 2 if (@x - Width / 2).abs < 1
    @y += 2 if (@y - Height / 2).abs < 1

    # v is greater closer to edges
    @vx = (Width/2 - @x).abs/10
    @vy = (Height/2 - @y).abs/10
    @vx = -@vx if @x < Width / 2
    @vy = -@vy if @y < Height / 2
    @shape = %w[ * . x O # @ ].sample
  end

  def update
    @x += @vx
    @y += @vy
    @vx = (Width/2 - @x).abs
    @vy = (Height/2 - @y).abs
    @vx = -@vx if @x < Width / 2
    @vy = -@vy if @y < Height / 2
    
    @vx = 1 if @vx > 0 && @vx < 0.2
    @vy = 1 if @vy < 0 && @vy < -0.2
  end
end

def draw(star)

end

stars = []


addstr("#{Height}, #{Width}")
300.times do |n|
  star = Star.new
  stars << star
  setpos(n + 1,0)
  addstr("#{p star}")
  refresh
  #getch
  
end
clear

begin
  loop do
    clear
    stars.each_with_index do |star, i|
      setpos(star.y, star.x)
      addstr(star.shape)
      star.update
      if star.x > Width - 1 || star.x < 0 || star.y > Height - 1 || star.y < 0
        stars[i] = Star.new
      end
    end
    refresh
    sleep 0.1
    #getch

  end
ensure
  close_screen
  
  #p stars 
  #p stars.group_by { |s| s.vx < 0 }
end


