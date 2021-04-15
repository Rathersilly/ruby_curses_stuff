require './guy_init'
require './guy_class'
require './shape'
require './window_monkey'
require './shape_demo'
require './vision_demo'
#require './guy_input'
require './guy_helper'



@demo = Demo.new
@demos = @demo.methods.select{ |m| m.start_with?('demo') }

@selection = 0
#demo_menu
create_map
loop do
  Map.refresh
  demo_vision
  #demo_looking_around
  #demo_menu(get_input)
  getch
  #test_draw_8ths
end

