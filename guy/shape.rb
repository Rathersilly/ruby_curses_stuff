class Point
  attr_accessor :x, :y

  def initialize(y, x)
    @y = y
    @x = x
  end
end

class Shape
  attr_accessor :win, :color

  class AttachError < ::StandardError
    def message
      super.to_s + ": Shape must be attached to a window to be drawn."
    end
  end

  def initialize
    @color = White
  end

  def draw
    if @win.nil?
      raise AttachError
    end
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

  def initialize(cy, cx, r,nls = 160, squish = 1)
    # center coordinates
    # @win = Win
    super()
    @cx = cx
    @cy = cy
    @r = r
    # nls = number of line segments
    @nls = nls
    @coords = []
    @squish = squish
  end

  def draw
    super
    @win.attron(color_pair(@color))
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
    @win.attroff(color_pair(@color))
  end

  def draw_8ths(delay = 0)
    # this is just to check window attachment
    method(:draw).super_method.call
    
    # by calculating for only 1/8 of circle and just
    # flipping signs, pixel symmetry is assured

    @win.attron(color_pair(@color))
    theta = 0
    curx = r.round
    cury = 0
    loop do
      theta += (2 * Math::PI)/@nls
      nextx = (r * Math.cos(theta)).round
      nexty = (r * Math.sin(theta)).round

      @win.draw_line(cy+cury,cx+curx,cy+nexty,cx+nextx)
      @win.draw_line(cy-cury,cx-curx,cy-nexty,cx-nextx)
      @win.draw_line(cy+cury,cx-curx,cy+nexty,cx-nextx)
      @win.draw_line(cy-cury,cx+curx,cy-nexty,cx+nextx)

      @win.draw_line(cy+curx,cx+cury,cy+nextx,cx+nexty)
      @win.draw_line(cy-curx,cx-cury,cy-nextx,cx-nexty)
      @win.draw_line(cy+curx,cx-cury,cy+nextx,cx-nexty)
      @win.draw_line(cy-curx,cx+cury,cy-nextx,cx+nexty)
      @win.refresh
      sleep delay

      curx = nextx
      cury = nexty
      break if theta > 2 * Math::PI / 8
    end
    @win.attroff(color_pair(@color))
  end

  def coords
  end
end
