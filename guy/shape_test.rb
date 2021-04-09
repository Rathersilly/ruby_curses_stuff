def test_line
  (0..Win.maxy - 1).each do |y|
    Win.draw_line(20,30,y,70)
    Win.refresh
    getch
    Win.clear
  end
end
def test_vert
  #(0..Win.maxx - 1).each do |x|
  (25..35).each do |x|
    #Win.draw_line(10,30,Win.maxy - 5,x)
    Win.draw_line(10,30,25,x)
    Win.refresh
    getch
    Win.clear
  end
end
def test_around
  x0 = Win.maxx/2
  y0 = Win.maxy/2
  xdir = 1
  ydir = 0
  x = 2
  y = 2
  count = (0..9).cycle.to_enum
  while true
    Win.draw_line(y0,x0,y,x, count.peek.to_s)
    Win.refresh
    #getch
    #sleep 0.05
    x += xdir
    y += ydir
    if x == Win.maxx - 3 && xdir != 0
      ydir = xdir
      xdir = 0
    elsif x == 2 && xdir != 0
      ydir = xdir
      xdir = 0
    elsif y == Win.maxy - 3 && ydir != 0
      xdir = -ydir 
      ydir = 0
    elsif y == 2 && ydir != 0
      xdir = -ydir
      ydir = 0
      count.next
    end
  end
end
def test_left
  x0 = Win.maxx/2
  y0 = Win.maxy/2
  x = 1

  (8..30).each do |y|
    Win.draw_line(y0,x0,y,x)
    Win.refresh
    getch
    #sleep 0.05
    Win.clear
  end
end
