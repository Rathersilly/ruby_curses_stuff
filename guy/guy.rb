require './guy_class'
require './guy_init'



create_map
@guy = Guy.new(5,20)
@guy.dest = [10,15]

loop do

create_map

  getch
  @guy.update


  draw
  Win.refresh
  Map.refresh

end


