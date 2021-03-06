module Helper
  def oob?(*args)
    #Log.puts "#{args.inspect}"
    y = 0
    x = 0
    if args[0].class == Array
      y = args[0][0]
      x = args[0][1]
    else
      y = args[0]
      x = args[1]
    end
    #Log.puts "y: #{y}, x: #{x}"
    if y < 1 || y > Win.maxy - 2
      return true
    elsif x < 1 || x > Win.maxx - 2
      return true
    end
    return false
  end
end

def daily_report
  Left.setpos(1,1)
  Left << "Day: #{@day}"
  Left.setpos(3,1)
  Left << "Plants: #{Plants.size}"
  Left.setpos(5,1)
  Left << "Watching: #{@watched.name}"
  Left.setpos(6,1)
  Left << "State: #{@watched.state}"
  Left.setpos(7,1)
  Left << "Hunger: #{@watched.hunger}/#{@watched.max_hunger}"
  Left.setpos(8,1)
  Left << "Age: #{@watched.age}"
  Left.setpos(9,1)
  Left << "Target: #{@watched.target}" 
  Left.setpos(10,1)
  Left << Msg
  Msg.replace("")
end
  
def day_cleanup
  Newplants.replace([])
  @day += 1
end
def update_things
  $stderr.puts Plants.inspect 
  $stderr.puts Herbs.inspect 
  Plants.each_with_index do |plant, i|
    Plants[i] = nil unless plant.update
  end
  Herbs.each_with_index do |x, i|
    Herbs[i] = nil unless x.update
  end
  #Log.puts "#{Herbs[0].inspect}"
  Plants.concat(Newplants)
  Herbs.concat(Newherbs)
end

def purge_things
  if Plants.include? nil
    #Log.puts "deleting from #{Plants}"
    Plants.delete(nil)
  end
  if Herbs.include? nil
    #Log.puts "deleting from #{Herbs}"
    Herbs.delete(nil)
  end
  OldPos.each do |pos|
    Win.setpos(pos[0],pos[1])
    Win << ' '
  end
end
def draw_things
  Plants.each do |x|
    x.draw
  end
  Herbs.each do |x|
    x.draw
  end
end