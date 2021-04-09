class Point
  attr_accessor :x, :y

  def initialize(y, x)
    @x = x
    @y = y
  end
end

class Shape
  attr_accessor :win, :color

  class AttachError < ::StandardError
    def message
      msg = super
      super.to_s + ": Shape must be attached to a window to be drawn."
    end
    # overriding this seems buggy - attempting to return anything
    # other than super or msg returns nil
    def backtrace
      msg = super
      #Win.gost 20,20,msg.class
      #Win.gost 24,20,msg.size rescue nil
      #"BACKTRACING: " + msg[0]
      msg
    end
  end

  def initialize
    @color = :white
  end

  def fill
    # this function might be best here - not
    # sure where to reset color though
  end
end

class Line < Shape
  attr_accessor :x0, :y0, :x1, :y1

  def initialize(y0, x0, y1, x1)
    @y0 = y0
    @y1 = y1
    @x0 = x0
    @x1 = x1
  end

  def draw
    if @win.nil?
      raise AttachError
    end
    @win.attron(color_pair(@color))
    @win.draw_line(y0, x0, y1, x1)
    @win.attroff(color_pair(@color))
  end
end

class Circle < Shape
  # Circle must be attached to a window
  attr_accessor :cx, :cy, :r

  def initialize(cy, cx, r,nls = 16, squish = 1)
    # center coordinates
    # @win = Win
    @cx = cx.to_f
    @cy = cy.to_f
    @r = r.to_f
    # nls = number of line segments
    @nls = nls
    @coords = []
    @squish = squish
  end

  def draw
    #Win.getch
    theta = 0
    curx = @cx + r 
    cury = @cy
    # going around entire circle
    loop do
      #break
      theta += (2 * Math::PI)/@nls
      nextx = @cx + r * Math.cos(theta)
      nexty = @cy + r * Math.sin(theta) * @squish
      # draw line segments
      # this is ok but not pixelly symmetrical
      # oh just draw 1/4?
      # oh nls should probs be a certain multiple
      @win.draw_line(cury.round,curx.round,nexty.round,nextx.round)

      # lol no 
      #@win.draw_line(cury.to_i,curx.to_i,nexty.to_i,nextx.to_i)
      #Win.getch
      curx = nextx
      cury = nexty
      break if theta > 2 * Math::PI
    end
  end

  def coords
  end
end
