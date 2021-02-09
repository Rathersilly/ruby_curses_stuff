require 'curses'
include Curses

init_screen
start_color
curs_set(0)
COLOR = 2 # green
INTERVAL = 0.1
HEIGHT = lines - 1
WIDTH = cols - 1

init_pair(1, COLOR, 0) # set purple on black
STDIN.cooked! #dsafjksd

class Codeline
  attr_accessor :row, :col, :ary, :next, :speed

  def initialize(row, col, msg)
    @next = false
    @ary = msg.split('')
    @row = row
    @col = col
    @z = rand(3) + 1
    #speed = highest at z = 0, reduced % at deeper z levels
    @speed = 1.0/@z

  end
end

codelines = []
WIDTH.times do |i|
  letters = ''
  HEIGHT.times do |i|

    letter = (65 + rand(26)).chr
    letter.upcase! if rand(2) == 0
    letters << letter
  end
  letters = "#{i}" * (HEIGHT/3)
  codelines << Codeline.new(rand(20), i, letters)
end


begin
  win = stdscr
  win.attron(color_pair(1))
  loop do
    # print letters 
    codelines.each do |codeline|
      row = codeline.row ; col = codeline.col
      codeline.ary.each_with_index do |c, i|
       
        break if row - i < 0
        win.setpos(row-i, col)
        rand(2) == 1 ? win << c : win << " "
      end
    end
    # 
    codelines.each do |codeline|
      codeline.row += 1 # codeline.speed/INTERVAL
      if codeline.row - codeline.ary.size > 0 && codeline.next == false
        codeline.next = true
        codelines << Codeline.new(0, codeline.col,"WELL HELLO THERE")
      end
      if codeline.row - codeline.ary.size > HEIGHT
        codelines.delete(codeline)
        codeline = nil
      end
    end
      # delete passed codelines
    win.refresh
    sleep INTERVAL

    win.clear
    


  end

end


