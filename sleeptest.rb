25.times do
  sleep 0.01
 #select(nil,nil,nil,0.01)
puts Time.now.usec/1000
end
