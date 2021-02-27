require 'curses'
include Curses
E = File.open("log", "w")

init_screen
noecho
curs_set(0)
#cbreak
Win = stdscr

class Body
  attr_accessor :pos, :mass, :speed, :shape
  def initialize(pos, mass, speed)
    # pos is y,x array
    @mass = mass
    @pos = pos
    @speed = speed
    @shape = "@"
    

  end
  def update(b)
    # caclulate force from each other object
    g = 2.0
    r = Math.sqrt((@pos[0] - b.pos[0])**2 + (@pos[1] - b.pos[1])**2)
    f = g*@mass * b.mass/(r**2)
    a = f/@mass
    # a y direction sin = (b.pos[0] - @pos[0]) / r
    # a x direction = b.pos[1] - @pos[1]
    # a y mag
    sin = (b.pos[0] - @pos[0]) / r
    cos = (b.pos[1] - @pos[1]) / r
    ay = sin * a
    ax = cos * a
    @speed[0] += ay / 2
    @speed[1] += ax / 2
    @pos[0] += @speed[0]
    @pos[1] += @speed[1]


    Win.setpos(0,0)
    Win << "radius: #{r}, f: #{f}, a: #{a}, sin: #{sin}, cos: #{cos}"
     

  end
end

#init things
#sun = Body.new([Win.maxy/2, Win.maxx/2], 100, 0)
sun = Body.new([Win.maxy/2, Win.maxx/2], 100, [0.0, 0.0])
earth = Body.new([20.0, 20.0], 1, [1.0,0.0])
bodies = [sun, earth]

#Win << bodies.inspect

loop do
  # update things
    
  Win << "wtf"
  Win.refresh

  E.puts "wtf"
  #Win.clear
  #getch
  sleep 0.1

end
#getch
