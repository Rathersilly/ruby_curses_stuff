require './guy_init'
require './shape'
require './window_monkey'
require './shape_test'
#require './guy_input'
require './guy_helper'



do_menu
create_map
loop do
  Map.refresh
  getch
  #do_menu(get_input)
  #test_draw_8ths
end

