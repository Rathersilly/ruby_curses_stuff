require 'curses'
require 'io/console'
include Curses

def create_map
  pillars = [[5,5],[5,10],[10,5],[10,10]]
  Map.setpos(0,0)
  Map << "X" * Map.maxx
  Map.maxy.times do |y|
    Map.setpos(y,0)
    Map << "X"
    Map.setpos(y,Map.maxx-1)
    Map << "X"
  end
  Map.setpos(Map.maxy-1,0)
  Map << "X" * Map.maxx

  pillars.each do |coord|
    Map.setpos(coord[0],coord[1])
    Map << "X"
  end
    
  
end

def update
end
def draw 
  Map.setpos(@guy.y,@guy.x)
  Map << "@"


end

Log = File.open("log", "w")
init_screen
noecho
curs_set(0)
Win = stdscr
Width = 90
Height = Win.maxy
Midx = Width/2
Midy = Height/2
Pi = Math::PI

# keyboard stuff
cbreak
#Win.timeout = 0
#stdscr.timeout =1000 
#Win.keypad = true

Map = Win.derwin(Height, Width, 0,Win.maxx-Width)
#Map = Win.derwin(Height, Width, (Win.maxy - Height)/2, (Win.maxx - Width)/2)
Map.box('|','-')


Map.setpos(1,1)
Map << "hey"
Map.refresh
def fill(coords)
  # fill area function: given array of coords, return
  # array of thos points within those coords
  Log.puts "FILLING"
  Log.puts "\n\nCoords: #{coords.inspect}"
  memo = []
  turn = 0
  #ys = coords.each_with_object([]) { |coord,acc| acc << coord[0] }
  #coords.reject! { |y,x| y == ys.min || y == ys.max }
  coords.each do |y,x|
    # find a coord with same y
    coords.each do |a,b|
      if y == a
        if x > b
          t = b + 1
          while t < x
            unless coords.include?([y,t])
              memo << [y,t]
              #Map.draw_coords("X",memo);Map.refresh;Map.getch
            end
            #memo << [y,t] unless coords.include?([y,t])
            t += 1
          end
        elsif b < x
          t = x + 1
          while t < b
            unless coords.include?([y,t])
              memo << [y,t]
              #Map.draw_coords("X",memo);Map.refresh;Map.getch
            end
            #memo << [y,t]  unless coords.include?([y,t])
            t += 1
          end
        end
      end
    end
  end

  Log.puts "MEMO: #{memo.inspect}"
  memo
end

