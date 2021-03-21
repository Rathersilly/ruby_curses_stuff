require './guy_init'
require './window_lines'
require './window_arcs'
require './guy_class'



create_map
@guy = Guy.new(Midy,Midx)
@guy.dest = [10,15]

@x = 30
@y = 2
theta = 0
loop do
  #Map.clear
  #draw_demo


  create_map
  Map.draw_circle(Midy,Midx,12)

  Map.refresh
  getch
  Map.clear
  #Map.draw_line_L(Midy,Midx,theta,30)
  theta += Math::PI / 8
  theta = 0 if theta >= Math::PI * 2
  #@guy.update


  draw
  Win.refresh
  Map.refresh

end


