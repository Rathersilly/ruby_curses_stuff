require 'benchmark'
# ok define screen class split screen into 3 horizontally
# theres is air, water, land
# border b/w air and water is moving waves
# otherborder is line
# sprites of airplane and ship and cars move in their zones

# screen class has contents, and row/col length
#
class Screen
  attr_accessor :lines, :cols, :contents

  def initialize
    @lines = 3
    @cols = 10
    @contents = "a" * @cols
    @contents += "n" * @cols
    @contents += "g" * @cols
  end

  def [](row, col)
    @contents[row * @cols + col]
  end

  def []=(row, col, thing)
    @contents[row * @cols + col] = thing

  end


  def draw
    contents.size.times do |i|
      print contents[i]
      print "\n" if (i + 1) % @cols == 0
    end
  end
end

class Sprite
  attr_accessor :row, :col, :shape

  def initialize(row, col, shape)
    @row = row; @col = col
    @shape = shape
  end
end
airplane = "A"
ship = "S"
car = "C"

s = Screen.new
s.draw
things = []
things << Sprite.new(0,0,airplane)
things << Sprite.new(1,0,airplane)
things << Sprite.new(2,0,airplane)

p s[0,0]
s[1,3] = 'X'
s.draw

