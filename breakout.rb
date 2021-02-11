require 'curses'
require 'io/console'
require './init_breakout.rb'
include Curses


count = 1

class Game
  
  def start
    begin
      # game loop
      loop do
        # loop through pieces and draw each one
        draw
        # get input
        get_input
        # loop through pieces and update their state
        update





        $stdin.iflush
        sleep 0.1
      end
    ensure
      close_screen
    end
  end
  def draw
    @win.clear
    @win.box("|", "-")
    @things.each do |thing|
      @win.setpos(thing.row, thing.col)
      @win << thing.image

    end
    @win.refresh
  end
  def get_input
    input = getch
    case input
    when 'h'
      @bar.col -= 3
      @bar.col = 1 if @bar.col < 1
    when 'l'
      @bar.col += 3
      if @bar.col + @bar.length > @win.maxx - 1
        @bar.col = @win.maxx - @bar.length - 1
      end
    end
  end
  def update
    
    #@things.each do |thing|
      #thing.update
    #end
  end

end
Game.new(test: false)
