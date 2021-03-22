require './guy_init'
require './window_lines'
require './window_arcs'
require './arcs2'
require './guy_class'



create_map
@guy = Guy.new(Midy,Midx)
@guy.dest = [10,15]

@x = 30
@y = 2
theta = 0.0
loop do
  #Map.clear
  #draw_demo


  create_map
  #Map.draw_circle(Midy,Midx,12)
  #Map.draw_circle(Midy,Midx,10)
  #Map.draw_circle2(Midy,Midx,16)
  # arc circles a point! cool!
  # could make it shoot like a synchrotron
  Map.draw_arc(Midy,Midx, theta - 2,theta,10)

  Map.refresh
  #getch
  sleep 0.1
  Map.clear
  #Map.draw_line_L(Midy,Midx,theta,30)
  theta += Math::PI / 16
  #theta = 0 if theta > Math::PI * 2
  #@guy.update


  draw
  Win.refresh
  Map.refresh

end


