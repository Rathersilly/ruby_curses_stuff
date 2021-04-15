# vision plan:
# create container (Window subclass?) to hold visible coords
# when drawing screen, only draw the coords in that container

# draw guy in middle of Map.
# for starters, just have him face directions and draw pie

def demo_vision
  
  guy = Guy.new(20,20)
  Map.attach(guy)
  
  loop do

    guy.dest[0] = rand(guy.win.maxy)
    guy.dest[1] = rand(guy.win.maxx)
    guy.update
    guy.get_sight



    Map.refresh

    sleep 0.2
    Map.clear

  end

end

def demo_looking_around
  guy = Guy.new(20,20)
  Map.attach(guy)
  
  loop do
    guy.dest[0] = rand(guy.win.maxy)
    guy.dest[1] = rand(guy.win.maxx)
    guy.update
    guy.get_dirxy

    Map.refresh

    sleep 0.2

  end

end
