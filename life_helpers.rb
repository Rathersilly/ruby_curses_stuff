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
  Left << Msg
  Msg.replace("")
end
  
def day_cleanup
  Newplants.replace([])
  @day += 1
end
def update_plants
  Plants.each_with_index do |plant, i|
    Plants[i] = nil unless plant.update
  end
  Log.puts "#{Plants[0].inspect}"
  Plants.concat(Newplants)
end
def update_herbs
  Herbs.each_with_index do |x, i|
    Herbs[i] = nil unless x.update
  end
  #Log.puts "#{Herbs[0].inspect}"
  Herbs.concat(Newherbs)
end

def purge_plants
  if Plants.include? nil
    Log.puts "deleting from #{Plants}"
    Plants.delete(nil)
  end
end
def purge_herbs
  if Herbs.include? nil
    Log.puts "deleting from #{Herbs}"
    Herbs.delete(nil)
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
