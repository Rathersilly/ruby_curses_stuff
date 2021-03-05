class Being
  attr_accessor :x, :y, :color, :age, :adult_age, :max_age, :shape
  attr_accessor :replicate, :rep_interval
  include Helper


  def initialize(y, x, max_age = 40)
    @y = y
    @x = x
    @age = 0
    @max_age = max_age
  end

  def draw
    Win.setpos(@y, @x)
    Win.attron(color_pair(@color)) { Win << @shape }
    Log.puts 'drawing'
  end

  def update
    @age += 1
    if @age > @max_age
      Win.setpos(@y, @x)
      Win << ' '
      Msg.replace("#{@name} died :(") unless self.class == Plant
      return nil
    end
    if @age == @adult_age
      @shape = @shapes[1]
      Msg.replace("#{@name} grew!") unless self.class == Plant
    end
    true
  end
end

class Plant < Being
  def initialize(y, x)
    @rep_interval = 10
    @replicate = @rep_interval
    @adult_age = 8

    @color = Green
    @shapes = ['.', Plant_image]
    @shape = @shapes[0]
    super(y, x)
  end

  def update
    return nil unless super

    @replicate -= 1
    if @replicate <= 0
      @replicate = @rep_interval
      # spread seed

      newy = rand(@y - 2..@y + 2)
      newx = rand(@x - 2..@x + 2)

      if newy < 1 || newy > Win.maxy - 2 ||
         newx < 1 || newx > Win.maxx - 2
        newy = nil
      else
        Win.setpos(newy, newx)
        newy = nil unless [' ', 'x'].include? Win.inch.chr
      end
      Plants << Plant.new(newy, newx) unless newy.nil?
    end
    true
  end
end
