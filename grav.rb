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
earth = Body.new([20.0, 10.0], 1, [0.6,0.0])
bodies = [sun, earth]

#Win << bodies.inspect

loop do
  # update things
  preve = [earth.pos[0], earth.pos[1]]
  prevs = [sun.pos[0],sun.pos[1]]
  earth.update(sun)
  #sun.update(earth)
  #Win.clear
  Win.setpos(preve[0], preve[1])
  Win << "."
  Win.setpos(prevs[0], prevs[1])
  Win << "x"
  bodies.each do |b|
    if b.pos[0] < Win.maxy && b.pos[0] > 0 && b.pos[1] < Win.maxx && b.pos[1] > 0
      Win.setpos(b.pos[0], b.pos[1])
      Win << b.shape
    end
  end
  Win.setpos(1,0)
  Win << "sun: #{sun.pos[0]}, #{sun.pos[1]}"
  Win.setpos(2,0)
  Win << "earth: #{earth.pos[0].to_i}, #{earth.pos[1].to_i}, speed: #{earth.speed[0].to_i}, #{earth.speed[1].to_i}"
  Win.refresh
    


  E.puts "wtf"
  #Win.clear
  #getch
  sleep 0.01

end
#getch
