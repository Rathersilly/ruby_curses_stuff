require 'curses'
include Curses

init_screen
#noecho
Log = File.new("log","a")
$stderr.reopen(Log)

Log.puts "hi"
$stderr.puts "there"
Win = stdscr
Adwin = Win.derwin(3,50,5,5)
Logwin = Win.derwin(6,Win.maxx - 10,Win.maxy - 8,5)
Adwin.box('|','-')
Logwin.box('|','-')

Adwin.refresh
Windows = [Win,Adwin].cycle

def focus(win)
  oldfocus = @focussed
  oldfocus.attroff(A_BOLD)
  oldfocus.box('|','-')
  oldfocus.refresh
  @focussed = win
  @focussed.attron(A_BOLD)
  @focussed.box('|','-')
  @focussed.attroff(A_BOLD)

  Log.puts "Changing focus from #{oldfocus.to_s} to #{@focussed.to_s}"
  Log.puts "#{Adwin.class} --- #{Adwin.inspect}"
  Logwin.setpos(1,1)
  Logwin << "Changing focus from #{oldfocus.to_s} to #{@focussed.to_s}"
  Logwin.refresh
  @focussed.setpos(1,1)
  @focussed.refresh

  
end
@focussed = Win
focus(Adwin)
def get_address
  @focussed.setpos(1,1)
  wcol = 1
  address = ""
  q = false
  while true
    c = @focussed.getch
    #Win.setpos(1,wcol)
    #Win << c.to_s
    #Win.refresh
    Log.puts address

    if c == 9         # tab
      focus(Windows.next)
      q = true
      #change focus
    elsif c == 10     # enter
      return address
    else
      address += c.chr
    end
    
    break if q == true
  end
end
#at_exit {I#

loop do
  #input = Adwin.getch
  
    address = get_address
  if @focussed == Adwin
  end
  #Adwin << input.to_s
    #address = get_address



  Win.setpos(1,1)
  Win << "Address: #{address}"

  Win.refresh
  Adwin.refresh

end


  
