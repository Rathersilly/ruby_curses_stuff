# Code that was intersting but unneeded

# this was in shape.rb - was gonna use it to draw
# a circle in 8ths, but my algo was wrong.  code preserved
# here cuz i liked the idea:

# man this was such a cool idea too bad math was wrong
# was gonna make array of method symbols, mapped with
# binary numbers
(0..7).each do |n|
sign = n.to_s(2).rjust(3,'0').split('')
Log.puts sign.to_s
sign.map! do |b|
b == "1" ? :+ : :-
end
Log.puts sign.to_s
end

# was gonna do draw_line(cy.send(sign[0],cury) ...),
# looping through the array

comment from shape.rb: Class AttachError
# overriding this seems buggy - attempting to return anything
# other than super or msg returns nil
def backtrace
msg = super
#Win.gost 20,20,msg.class
#Win.gost 24,20,msg.size rescue nil
#"BACKTRACING: " + msg[0]
msg
end

