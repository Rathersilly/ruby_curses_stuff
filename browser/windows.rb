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
Adwin.box('|','-')

Adwin.refresh
Windows = [Win,Adwin].cycle

def focus
  oldfocus = $focus
  $focus.attroff(A_BOLD)
  $focus.box('|','-')
  $focus.refresh
  $focus = Windows.next
  $focus.attron(A_BOLD)
  $focus.box('|','-')
  $focus.attroff(A_BOLD)
  $focus.refresh
  Log.puts "Changing focus from #{oldfocus.to_s} to #{$focus.to_s}"
  
end
$focus = Win
focus
def get_address
  Adwin.setpos(1,1)
  wcol = 1
  address = ""
  q = false
  while true
    c = Adwin.getch
    #Win.setpos(1,wcol)
    #Win << c.to_s
    #Win.refresh
    Log.puts address

    if c == 9
      focus
      q = true
      #change focus
    elsif c == 10
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
  #Adwin << input.to_s
    #address = get_address



  Win.setpos(1,1)
  Win << "Address: #{address}"

  Win.refresh
  Adwin.refresh

end


  
