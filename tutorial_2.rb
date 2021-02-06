# https://www.2n.pl/blog/basics-of-curses-library-in-ruby-make-awesome-terminal-apps
require 'curses'

include Curses
# the original tutorial involved creating a menu to select ssh hosts
#config = File.read(File.expand_path('~/.ssh/config')).lines
#ALIASES = config.grep(/^Host/).map { |line| line.sub(/^Host/, '').strip }.sort
# MAX_INDEX = ALIASES.size - 1

# but there are more important things than ssh hosts. Things like:
THINGS = ["Alligator", "Bazooka", "Catastrophe"]
MAX_INDEX = THINGS.size - 1
MIN_INDEX = 0

@index = 0

init_screen # Initializes a standard screen. At this point the present state
            # of our terminal is saved and the alternate screen buffer is turned on
start_color # Initializes the color attributes for terminals that support it.
curs_set(0) # Hides the cursor
noecho # Disables characters typed by the user to be echoed by Curses.getch as they are typed.


# three arguments: the number of the color-pair to be changed,
# the foreground color number f,
# and the background color number b.
#init_pair(1, 1, 0) # ie color_pair(1) has fg of 1(red) and bg of 0(black)

THIS_PAIR = 1 # the color pair must have a number - should probably have c-like enum with constants
init_pair(THIS_PAIR, 1, 0)


begin
  win = Curses::Window.new(0, 0, 1, 2)

  loop do
    win.setpos(0,0) # we set the cursor on the starting position

    THINGS.each.with_index(0) do |str, index| # we iterate through our data
      if index == @index # if the element is currently chosen...
        win.attron(color_pair(THIS_PAIR)) { win << str } #...we color it red
      else
        win << str # rest of the elements are output with a default color
      end
      clrtoeol # clear to end of line
      win << "\n" # and move to next
    end
    win.refresh

    str = win.getch.to_s
    case str
    when 'j'
      @index = @index >= MAX_INDEX ? MAX_INDEX : @index + 1
    when 'k'
      @index = @index <= MIN_INDEX ? MIN_INDEX : @index - 1
    when '10'
      @selected = THINGS[@index]
      msg = "YOU HAVE CHOSEN #{@selected}"
      win.setpos((lines/2 - 1), (cols/2 - 1) - msg.size/2)
      win << msg
      win.refresh
      sleep 5
      exit 0
    when 'q' then exit 0
    end
  end
ensure
  close_screen
  # exec "ssh #{@selected}" if @selected
end



