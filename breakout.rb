require 'curses'
require 'io/console'
require './init_breakout'
include Curses
init_screen
# Win = stdscr.derwin(30, 50, 0, 0)
Win = stdscr.derwin(20, 30, 0, 0)
Rows = Win.maxy; Cols = Win.maxx

curs_set(0) # 0=invis, 1=vis, 2=veryvis
cbreak # disables line buffering - turn off w/ nocbreak
noecho
stdscr.keypad = true
# Win.keypad = true 
stdscr.timeout = 0
Win.box("|", "-")
start_color
init_pair(1, 1, 0)
init_pair(4, 4, 0)

count = 1

class Game
  def start
    # game loop
    @frame = 0
    loop do
      # loop through pieces and draw each one
      draw
      # get input
      get_input
      # loop through pieces and update their state
      update_pos

      $stdin.iflush
      @frame += 1
      sleep 0.1
    end
  ensure
    close_screen
  end

  def draw
    #stdscr.clear
    Win.clear
    Win.box('|', '-')
    Win.setpos(0,0)
    Win.addstr("frame #{@frame}, key: #{@key}, vx: #{@ball.vx}, vy: #{@ball.vy}, msg: #{@msg}")
    #setpos(1,50)  # => 
    #addstr("#{@bar.pixels}, #{@ball.row}, #{@ball.col}")
    

    @things.each do |thing|
      Win.setpos(thing.row, thing.col)
      Win.attron(color_pair(thing.color)) { Win << thing.image }
    end
    Win.refresh
  end

  def get_input
    input = getch
    @key = input
    case input
    when ?h, KEY_LEFT
      @bar.col -= 3
      @bar.col = 1 if @bar.col < 1
    when ?l, KEY_RIGHT
      @bar.col += 3
      @bar.col = Win.maxx - @bar.length - 1 if @bar.col + @bar.length > Win.maxx - 1
    # when  ?p # pause
    # when ?s  # slowmo
    end
    @bar.update_pixels
  end

  def update_pos
    # update ball position
    # if ball pos is same as any part of bar, change ball's pos and angle
    # this function needs access to bar pixels so cant be in Ball class
    @ball.row += @ball.vy
    @ball.col += @ball.vx
    pos = [@ball.row, @ball.col]
    @msg = "#{@bar.pixels} POS: #{pos}"


    # check if ball and bar collide
    if @bar.pixels.include?(pos)
      pix = @bar.image[@ball.col - @bar.col]

      if pix == '1'
        @ball.row -= 1
        @ball.vx = -1.5
        @ball.vy = -1
        @ball.row += @ball.vy
        @ball.col += @ball.vx
      elsif pix == '5'
        @ball.row -= 1
        @ball.vx = 1.5
        @ball.vy = -1
        @ball.row += @ball.vy
        @ball.col += @ball.vx
      elsif pix == '3'
        @ball.row -= 1
        @ball.vy = -@ball.vy
        @ball.row += @ball.vy
        @ball.col += @ball.vx
      end
    end

    if @ball.row == Rows - 1
      @ball.row = Rows - 2
      @ball.vy = -@ball.vy
    elsif @ball.row == 0
      @ball.row = 1
      @ball.vy = -@ball.vy
    end
    if @ball.col >= Cols - 1
      @ball.col = Cols - 2
      @ball.vx = -@ball.vx
    elsif @ball.col <= 0
      @ball.col = 1
      @ball.vx = -@ball.vx
    end
    #@ball.things.each do |thing|
      #thing.update
      # check collision
      
  end
  def collide

  end
end
Game.new(test: false)
