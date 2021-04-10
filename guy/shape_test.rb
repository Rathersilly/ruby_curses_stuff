def test_line
  (0..Win.maxy - 1).each do |y|
    get_input
    Win.draw_line(20,30,y,70)
    Win.refresh
    sleep 0.2
    #getch
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

def test_circle_nls
  # intcrementing nls gives cool shimmering effect
  first = 80
  last = 120
  step = 4
  (first..last).step(step).each do |nls|
    c = Circle.new(Midy,Midx,16,nls)
    Win.attach(c)
    c.draw
    Win.gost 10,30, "nls: ",nls
    Win.refresh
    #sleep 0.1
    Win.getch
    Win.clear
  end
end

def test_squish
  first = 1
  last = 10
  step = 1
  (first..last).step(step).each do |squish|
    c = Circle.new(Midy,Midx,16,128, squish * 0.1)
    c.color = Colors.next
    Win.attach(c)

    c.draw
    Win.gost 10,30, "squish: ",(squish * 0.1).round(1)
    Win.refresh
    #sleep 0.1
    Win.getch
    Win.clear
  end
end

def test_squish_input
  first = 1
  last = 10
  step = 1
  squish = 1.0
  while true
    case get_input
    when ?h, ?j
      squish -= 1
    when ?k, ?l
      squish += 1
    when ?q
    break
    end

    c = Circle.new(Midy,Midx,16,128, squish * 0.1)
    c.color = Colors.next
    Win.attach(c)

    c.draw
    Win.gost 10,30, "squish: ",(squish * 0.1).round(1)
    Win.refresh
    sleep 0.1
    Win.clear
  end
end

def test_draw_8ths
  loop do
    c = Circle.new(Midy,Midx,16)
    Win.attach(c)
    c.color = Cyan
    c.draw_8ths
    Win.refresh
    sleep 0.1
  end
end

def test_draw_arcs
  a0 = 0
  a1 = Math::PI/4
  step = Math::PI/32
  loop do
    Win.draw_arc(Midy,Midx,a0,a1,10)
    Win.refresh
    a0 += step
    a1 += step
    getch
    Win.clear

  end
end

