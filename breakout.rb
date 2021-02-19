require 'curses'
require 'io/console'
require './init_breakout'
require './breakout_collide.rb'
include Curses

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
    @blocks.each do |block|
      Win.setpos(block.row, block.col)
      if block.damage == 0
        Win.attron(color_pair(block.color)) { Win << block.image }
      elsif block.damage == 1
        Win.attron(color_pair(block.color)) { Win << block.image_damaged }

      end
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

end
Game.new(test: false)
