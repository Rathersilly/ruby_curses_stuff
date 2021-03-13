class Target
  attr_accessor :y,:x
  def initialize(y = 0,x = 0)
    @y = y
    @x = x
  end
end
class Animal < Being
  attr_accessor :name, :state, :hunger, :hunger_max, :hunger_threshold, :target, :sex
  def initialize(y, x)
    super(y,x)
  end
  def update
    if @hunger > @hunger_max
      @state = :dead
    end
    super
  end
end
class Herb < Animal
  def initialize(y, x, name = "herbivore")
    @max_age ||= 50
    @rep_interval = 10
    @name = name
    @replicate = @rep_interval
    @adult_age = 10
    rand(2) == 0 ? @sex = :male : @sex = :female
    

    @color ||= Yellow
    @shapes = ['h',"H"]
    @shape = @shapes[0]
    @state = :idle
    @hunger = 0
    @hunger_threshold = 20
    @hunger_max = 50
    @health = 2
    @y = y
    @x = x
    @target = Target.new(@y,@x)
    super(y,x)
    
  end
  def update
    return nil unless super
    @hunger += 1
    @replicate -= 1 if @age > adult_age
    
    if @hunger > @hunger_threshold
      @state = :hungry
    elsif @state == :idle && replicate <= 0
      @state = :horny
    end
    if @state == :hungry
      do_hungry
    elsif @state == :horny
      do_horny
    elsif @state == :dead
      # do_dead
    end


    Log.puts "in update, target: #{target}"
    if @target == nil
        find_random_target
    elsif @target.y == @y && @target.x == @x
      if @target.class == Plant
        Msg.replace("EATING")
        eat
      elsif @target.class == Herb
        Msg.replace("LOVIN")
        love
      else
        find_random_target
      end
    end
    approach_target if @target
    
    # approach target
    return true
  end
  def do_hungry
    find_food if @target.class != Plant
  end
  def do_horny
    find_mate if @target.class != Herb
  end

  def find_random_target
    begin
      y = @y + rand(-3..3)
      x = @x + rand(-3..3)
    end while oob?(y,x)
    @target = Target.new(y,x)
  end
  def find_mate
    # go througy Herbs, find closest opposite sex
    Log.puts "finding mate"

    closest = nil
    min = 1000
    Herbs.each do |h|
      next if h.nil?
      if h.sex != @sex
        d = dist(@y,@x,h.y,h.x)
        if min > d
          closest = h
          min = d
        end
      end
        
    end
    @target = closest
    
  end

  def eat
    @hunger = 0
    @state = :idle 
    @target.state = :dead
    @target = nil
    #find_random_target
  end
  def love
    child = Herb.new(@y,@x)
    rand(2) == 0 ? Herbs << child : child = nil
    Messages[:herb_births] += 1
    @replicate = @rep_interval
    @state = :idle
    @target.state = :idle
    @target.replicate = @target.rep_interval
    @target = nil
    
  end
  def approach_target
    Log.puts "approach: #{@target.inspect}"
    Log.puts "my pos before: #{@y}, #{@x}"
    y = @y
    x = @x
    if @target.y > @y
      @y += 1
    elsif @target.y < @y
      @y -= 1
    end
    if @target.x > @x
      @x += 1
    elsif @target.x < @x
      @x -= 1
    end
    if y != @y || x != @x
      OldPos << [y,x]
    end
    Log.puts "my pos after: #{@y}, #{@x}"
  end
  def find_food
    Log.puts "Searching for target"

    # if hungry, find nearest plant
    # look in a spiral starting with y,x 
    spiral = 1
    target_flag = false
    cy = 0; cx = 0
    loop do
      (-spiral..spiral).each do |dy|
        (-spiral..spiral).each do |dx|

          cy = @y + dy
          cx = @x + dx
          next if dy.abs != spiral.abs && dx.abs != spiral.abs
          Log.puts "cy: #{cy}, cx: #{cx}"

          next if oob?(cy,cx)
          Win.setpos(cy, cx)
          Log.print("#{cy}, #{cx}: #{Win.inch.chr}")
          if Win.inch.chr == Plant_image
            target_flag = true 
          else
            if Win.inch.chr != "X"
              #Win << "X"
            else
              #Win << "O"
            end
          end
          Win.refresh
          #getch
          break if target_flag == true
        end
        break if target_flag == true
      end
      break if target_flag == true
      spiral += 1
      if spiral > 3
        find_random_target
        return false
      end
    end
    Log.puts "Targetflag: #{target_flag}"


    # search through plants by position
    #move to plant, eat it
    Log.puts "plants: #{Plants.inspect}"
    #Log.puts Plants.find { |x| x.y == cy && x.x == cx }
    @target = Plants.find do |x| 
      next if x.nil?
      x.y == cy && x.x == cx 
    end
    @target.color = Yellow
    Log.puts "Target: #{@target}"
    return true
      

  end

end

