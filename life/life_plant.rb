require './life_helpers'
class Being
  attr_accessor :x, :y, :color, :age, :adult_age, :max_age, :shape
  attr_accessor :replicate, :rep_interval, :state
  include Helper


  def initialize(y, x)
    @y = y
    @x = x
    @age = 0
  end


  def update
    @age += 1
    if @age > @max_age || @state == :dead
      Win.setpos(@y, @x)
      Win << ' '
      Messages[:reports] <<  "#{@name} died(age)" unless self.class == Plant
      return nil
    end
    if @age == @adult_age
      @shape = @shapes[1]
      Messages[:reports] << "#{@name} grew!" unless self.class == Plant
    end
    true
  end
end

class Plant < Being
  def initialize(y, x)
    @max_age = 40
    @rep_interval = 10
    @replicate = @rep_interval
    @seed_radius = 3
    @adult_age = 8

    @color = Green
    @shapes = ['.', Plant_image]
    @shape = @shapes[0]
    @state = :alive
    super(y, x)
  end

  def update
    return nil unless super

    @replicate -= 1 if @age > adult_age
    if @replicate <= 0
      @replicate = @rep_interval
      # spread seed

      newy = rand(@y - @seed_radius..@y + @seed_radius)
      newx = rand(@x - @seed_radius..@x + @seed_radius)

      if oob?(newy, newx)
        newy = nil
      else
        Win.setpos(newy, newx)
        if ' ' == Win.inch.chr
          Plants << Plant.new(newy, newx) unless newy.nil?
        else
          newy = nil
        end
      end
    end
    true
  end
end
