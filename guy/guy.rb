require './guy_init'
require './guy_helpers'
require './guy_class'



create_map
@guy = Guy.new(5,20)
@guy.dest = [10,15]

@x = 30
@y = 2
loop do
  #Map.clear
  #draw_demo


  create_map

  Map.refresh
  getch
  Map.clear
  @guy.update


  draw
  Win.refresh
  Map.refresh

end


