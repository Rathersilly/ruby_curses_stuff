require './guy_init'
require './window_lines'
require './window_arcs'
require './arcs2'
require './guy_class'



create_map
@guy = Guy.new(Midy,Midx)
@guy.dest = [10,15]

@x = 30
@y = Midy
radius = 10
theta = 0.0
dx = 1
loop do
  
  coords = Map.draw_circle2(@y,@x,radius)
  fill_coords = fill(coords)
  Map.draw_coords("#",fill_coords)
  @x += dx
  if @x == Map.maxx - radius
    @x = Map.maxx - radius
    dx = -dx
  elsif @x == 0+ radius
    dx = - dx
  end
  Map.refresh; Win.refresh
  sleep 0.01; Map.clear; Win.clear;
end

loop do
  # draw arc and 2 lines - put all points in array
  Win << "Map.draw_line_L(Midy,Midx,theta,10)"
  coords = []
  coords += Map.draw_line_L(Midy,Midx,theta - 2,10)
  coords += Map.draw_line_L(Midy,Midx,theta ,10)
  coords += Map.draw_arc(Midy,Midx, theta - 2,theta,10)
  fill_coords = fill(coords)
  Map.draw_coords("#",fill_coords)

  Map.refresh; Win.refresh;
  sleep 0.1
  Map.clear; Win.clear;
  theta -= Math::PI / 16
  theta = 0 if theta > Math::PI * 2
  break

end
Map.getch
loop do
  #Map.clear
  #draw_demo


  create_map

  Win.setpos(5,3)
  Win << "coords = Map.draw_circle2(Midy,Midx,10)"
  coords = Map.draw_circle2(Midy,Midx,10)
  Win.setpos(7,3)
  Win << "fill_coords = fill(coords)"
  fill_coords = fill(coords)
  Win.setpos(9,3)
  Win << "Map.draw_coords('#',fill_coords)"
  Map.draw_coords("#",fill_coords)
  Map.refresh; Win.refresh; getch; Map.clear; Win.clear;

  Win.setpos(5,3)
  Win << "Map.draw_arc(Midy,Midx, theta - 2,theta,10)"
  Map.draw_arc(Midy,Midx, theta - 2,theta,10)
  Map.refresh; Win.refresh; getch; Map.clear; Win.clear;
  
  Win.setpos(5,3)
  Win << "Map.draw_circle(Midy,Midx,12)"
  Map.draw_circle(Midy,Midx,12)
  Map.refresh; Win.refresh; getch; Map.clear; Win.clear;

  # draw arc and 2 lines - put all points in array
  Win << "Map.draw_line_L(Midy,Midx,theta,10)"
  coords = []
  coords += Map.draw_line_L(Midy,Midx,theta - 2,10)
  coords += Map.draw_line_L(Midy,Midx,theta ,10)
  coords += Map.draw_arc(Midy,Midx, theta - 2,theta,10)
  fill_coords = fill(coords)
  Map.draw_coords("#",fill_coords)

  Map.refresh; Win.refresh; getch; Map.clear; Win.clear;

  Map.refresh; Win.refresh; getch; Map.clear; Win.clear;
  #sleep 0.1
  Map.clear
  #Map.draw_line_L(Midy,Midx,theta,30)
  theta -= Math::PI / 16
  #theta = 0 if theta > Math::PI * 2
  #@guy.update


  draw
  Win.refresh
  Map.refresh

end


