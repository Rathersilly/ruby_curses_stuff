class Animal < Being
  attr_accessor :name, :state, :hunger, :max_hunger, :target
  def initialize(y, x)
    super(y,x)
  end
end
class Herb < Animal
  def initialize(y, x)
    @rep_interval = 10
    #@name = "Herby"
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
    @state = :hungry if @hunger > 1
    find_target if @state == :hungry
    return true
  end
  def find_target
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
      return false if spiral > 3
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

