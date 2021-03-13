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
    #$stderr.puts "in oob"
    #$stderr.puts "x: #{x}, y: #{y}, maxy: #{Win.maxy}, maxx: #{Win.maxx}"
    if y < 1 || y > Win.maxy - 2
      return true
    elsif x < 1 || x > Win.maxx - 2
      return true
    end
    return false
  end
  def dist(x,y,a,b)
    x = x.to_f
    y = y.to_f
    Math.sqrt((x-a).abs ** 3 + (y-b).abs ** 2)
  end
end

def daily_report
  Left.setpos(1,1)
  Left << "Day: #{@day}"
  Left.setpos(3,1)
  Left << "Plants: #{Plants.size}"
  Left.setpos(4,1)
  Left << "Herbivores: #{Herbs.size}"
  Left.setpos(5,1)
  Left << "Watching: #{@watched.name}"
  Left.setpos(6,1)
  Left << "State: #{@watched.state}"
  Left.setpos(7,1)
  Left << "Hunger: #{@watched.hunger}/#{@watched.hunger_max}"
  Left.setpos(8,1)
  Left << "Age: #{@watched.age}"
  Left.setpos(9,1)
  Left << "Pos: #{@watched.y}, #{@watched.x}"
  if Msg == "EATING"
    Left.setpos(10,1)
    Left << "Target: FOOD"
  else
    Left.setpos(10,1)
    Left << "Target: #{@watched.target.class}"
  end
  Left.setpos(11,1)
  Left <<  "Target yx: #{@watched.target.y}, #{@watched.target.y}" if @watched.target
  Left.setpos(12,1)
  Left << Msg
  Msg.replace("")
  Left.setpos(14,1)
  Left << "Horny: #{@watched.replicate}, #{@watched.rep_interval}"
  pos = 15
  Left.setpos(pos, 1)
  Left << "Herb deaths: " << Messages[:herb_deaths].to_s 
  pos += 2
  Left.setpos(pos, 1)
  Left << "Herb births: " << Messages[:herb_births].to_s 
  pos += 2
  Messages[:reports].each do |k,v|
    Left.setpos(pos, 1)
    Left << k.to_s << " " << v.to_s
    pos += 2
  end
  Messages[:reports].replace([])


end
  
def day_cleanup
  Newplants.replace([])
  @day += 1
end
def update_things
  #$stderr.puts Plants.inspect 
  #$stderr.puts Herbs.inspect 
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
    Messages[:herb_deaths] += Herbs.count(nil)
    Herbs.delete(nil)
  end
  OldPos.each do |pos|
    Win.setpos(pos[0],pos[1])
    Win << ' '
  end
end
def draw_things
  count = 0
  Plants.each do |x|
    draw(x)
    count += 1
  end
  Herbs.each do |x|
    draw(x)
    count += 1
  end
  Log.puts 'drew #{count} things!'

end
def draw(being)
  Win.setpos(being.y, being.x)
  Win.attron(color_pair(being.color)) { Win << being.shape }
end
