require 'curses'
require 'logger'
require './actors'
require './guy'

include Curses
include Guys

log = Logger.new('log')

init_screen
HEIGHT = lines > 30 ? 30 : lines
WIDTH = cols > 80 ? 80 : cols
INTERVAL = 0.2
GRAV = 0.3
BOUNCES_BEFORE_EXPLODE = 3
THROWING_SPEED = 3
SHRAPNEL_SPEED = 25.0

top = (Curses.lines - HEIGHT) / 2
left = (Curses.cols - WIDTH) / 2
LGUY_X = left + 26; LGUY_Y = 20
RGUY_X = left + 56; RGUY_Y = 20

grenade = Grenade.new
actors = []
# actors << grenade
# actors << Grenade.new(20,15,9.0,-10)
active_nades = 2
frame = 0
begin
  win = Curses::Window.new(HEIGHT, WIDTH, top, left)
  win.box('|', '-')
  win.refresh
  l_win = win.derwin(3, 4, HEIGHT - 5, 5)
  r_win = win.derwin(3, 4, HEIGHT - 5, WIDTH - 9)
  # l_win = Window.new(3, 4, LGUY_Y, LGUY_X)
  # r_win = Window.new(3, 4, RGUY_Y, RGUY_X)
  loop do
    frame += 1; frame = 0 if frame == 7
    if active_nades < -1
      # actors << Grenade.new(rand(0..WIDTH), rand(0..HEIGHT/2), rand(-20..10), rand(-20..10))
      active_nades += 1
    end

    # Draw guys
    l_win.setpos(0, 0)
    l_win << LGUY.next
    l_win.refresh
    r_win.setpos(0, 0)
    r_win << RGUY.next
    r_win.refresh
    # if throwing animation is in right spot
    if [0, 3].include?(frame) # true #LGUY.peek == LGUY.to_a.last
      new_guy = Grenade.new(8, HEIGHT - 7, 0, 0) # (LGUY_X + 6, LGUY_Y - 4, 0, 0)
      angle = Math::PI * 3 / 8
      new_guy.vx = 15 # Math.cos(angle) * THROWING_SPEED
      new_guy.vy = -Math.sin(angle) * THROWING_SPEED
      # new_guy = Dot.new(10, 10)#(LGUY_X, LGUY_Y)
      actors << new_guy
      # log.info("LGUY_X: #{LGUY_X}, LGUY_Y: #{LGUY_Y}")
      log.info("#{new_guy.name}: x:(#{new_guy.x}, y:#{new_guy.y}), vx: #{new_guy.vx}, vy: #{new_guy.vy}")
      log.info("#{new_guy.name}: x:(#{new_guy.x}, y:#{new_guy.y})")
    end
    if false # RGUY.peek == RGUY.to_a.last
      new_guy = Grenade.new(RGUY_X - 1, RGUY_Y - 1, 0, 0)
      angle = Math::PI * 3 / 4
      new_guy.vx = Math.cos(angle) * THROWING_SPEED
      new_guy.vy = Math.sin(angle) * THROWING_SPEED
      actors << new_guy
    end

    # end
    # win.setpos(WIDTH - 10, 10)
    # win << RGUY.next
    # Draw actors
    actors.each do |actor|
      # WAAAAAY too much to log
      log.info("HI#{actor.name}: win.setpos(#{actor.y}, #{actor.x})")
      win.setpos(actor.y, actor.x)
      win << actor.shape
      win.setpos(0, 0)
      win << "x: #{actor.x.to_i}, y: #{actor.y.to_i}, vx: #{actor.vx}, vy: #{actor.vy}"
    end

    win.refresh
    actors.each do |actor|
      break if actor.y.nil? || actor.x.nil?

      win.setpos(actor.y, actor.x)
      win << ' '
    end
    actors.each do |actor|
      actor.update
      next unless actor.name.include?('Grenade') && actor.bounces > BOUNCES_BEFORE_EXPLODE && !actor.spent

      actor.spent = true
      active_nades -= 1
      (0..7).each do |i|
        actors << Shrapnel.new(actor.x, actor.y, *i * Math::PI / 4 + rand(-1..1) * Math::PI / 12)
      end
    end

    # win.setpos(0,0)
    # win << "x: #{actor.x.to_i}, y: #{actor.y.to_i}, vx: #{actor.vx}, vy: #{actor.vy}"
    sleep INTERVAL
  end
ensure
  win.close
end
