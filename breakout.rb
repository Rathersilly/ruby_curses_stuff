require 'curses'
require 'io/console'
require './init_breakout'
include Curses
init_screen
# Win = stdscr.derwin(30, 50, 0, 0)
Win = stdscr.derwin(20, 38, 10, 10)
# Win = stdscr.derwin(11, 13, 5, 10)
Rows = Win.maxy; Cols = Win.maxx

curs_set(0) # 0=invis, 1=vis, 2=veryvis
cbreak # disables line buffering - turn off w/ nocbreak
noecho
stdscr.keypad = true
# Win.keypad = true 
stdscr.timeout = 0
start_color
init_pair(1, 1, 0)
init_pair(2, 2, 0)
init_pair(3, 3, 0)
init_pair(4, 4, 0)
init_pair(7, 0, COLOR_BLUE)
Bar_pair = 12
init_pair(Bar_pair, COLOR_BLACK, COLOR_BLUE)
Win.box("|", "-")

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
      collide

      $stdin.iflush
      @frame += 1
      # sleep 0.05
      sleep 0.1
    end
  ensure
    close_screen
  end

  def draw
    stdscr.clear
    Win.clear
    Win.box('|', '-')
    Win.bkgd(color_pair(7))
    stdscr.setpos(0,5)
    stdscr.addstr("frame #{@frame}, key: #{@key}, vx: #{@ball.vx}, vy: #{@ball.vy}")
    stdscr.setpos(1,5)
    stdscr.addstr("msg: #{@msg}")
    stdscr.setpos(3,5)
    stdscr.addstr("msg2: #{@msg2}")
    stdscr.refresh
    # Win.addstr("frame #{@frame}, key: #{@key}, vx: #{@ball.vx}, vy: #{@ball.vy}, msg: #{@msg}")
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

    pos = [@ball.row.to_i, @ball.col.to_i]
    @msg = "Bar pixels: #{@bar.pixels}\n     Ball position: #{pos}"

  end

  def collide
    pos = [@ball.row.to_i, @ball.col.to_i]
    
    # Edge case - stop ball from sneaking by literal edge
    if pos[0] == @bar.row
      if pos[1] == 0 && @bar.col == 1
        @ball.col = 1
      elsif pos[1] == Cols - 1 && @bar.col = Cols - 1 - @bar.length
        @ball.col = Cols - 1
      end
    end
    
    # Ball colliding with bar
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

    # Ball colliding with border
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
  end
end
Game.new(test: false)
