class Point
  attr_accessor :x, :y

  def initialize(y, x)
    @x = x
    @y = y
  end
end

class Shape
  class AttachError < ::StandardError
    def message
      msg = super
      super.to_s + ": You gotta attach to a window, noob."
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
  attr_accessor :win, :color

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
    @win.attron(color_pair(@color))
  end
end

class Circle < Shape
  # Circle must be attached to a window
  attr_accessor :cx, :cy, :r

  def initialize(cy, cx, r)
    # center coordinates
    # @win = Win
    @cx = cx.to_f
    @cy = cy.to_f
    @r = r.to_f
    # nls = number of line segments
    @nls = 30
    @coords = []
  end

  def draw
    # start at 0 radians
    # first point is x,y
    x = @cx + r
    y = @cy
    dist = @nls / (2 * Math::PI)
    ny =
      loop do
        # draw line segment
        @win.draw_line(@cy, @cx, @cy, @cx)
        break
      end
  end

  def coords
  end
end
