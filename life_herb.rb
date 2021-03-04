class Animal < Being
  attr_accessor :name, :state, :hunger, :max_hunger
  def initialize(y, x)
    super(y,x)
  end
end
class Herb < Animal
  def initialize(y, x)
    @name = "Herby"
    @rep_interval = 10
    @replicate = @rep_interval
    @adult_age = 10

    @color = Yellow
    @shapes = ['h',"H"]
    @shape = @shapes[0]
    @state = :idle
    @hunger = 0
    @max_hunger = 5
    @health = 2
    
    super(y,x)
  end
  def update
    return nil unless super
    @hunger += 1
    @state = @hungry if @hunger > 1
    return true
    
  end


end

