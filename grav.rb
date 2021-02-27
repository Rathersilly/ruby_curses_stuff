require 'curses'
include Curses

init_screen
noecho
curs_set(0)
Win = stdscr

class Body
  attr_accessor :pos, :mass, :speed, :shape
  def initialize(pos, mass, speed)
    # pos is y,x array
    @pos = pos
    @mass = mass
    @speed = speed
    @shape = "@"
    

  end
  def update(b)
    # caclulate force from each other object
    g = 1
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
    @speed[0] += ay
    @speed[1] += ax
    @pos[0] += @speed[0]
    @pos[1] += @speed[1]


    Win.setpos(0,0)
    Win << "radius: #{r}, f: #{f}, a: #{a}, sin: #{sin}, cos: #{cos}"
     

  end
end

#init things
sun = Body.new([20.0,30.0], 100, 0)
earth = Body.new([20.0, 80.0], 1, [0.5,0.0])
bodies = [sun, earth]

Win << bodies.inspect

loop do
  # update things
  earth.update(sun)
  Win.clear
  bodies.each do |b|
    if b.pos[0] < Win.maxy && b.pos[0] > 0 && b.pos[1] < Win.maxx && b.pos[1] > 0
      Win.setpos(b.pos[0], b.pos[1])
      Win << b.shape
    end
  end
  Win.setpos(1,0)
  Win << "sun: #{sun.pos[0]}, #{sun.pos[1]}"
  Win.setpos(2,0)
  Win << "earth: #{earth.pos[0]}, #{earth.pos[1]}, speed: #{earth.speed[0]}, #{earth.speed[1]}"
    


  getch

end
getch
