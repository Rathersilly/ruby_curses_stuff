def oob?(*args)
  maxx = 20
  maxy = 20
  y = 0
  x = 0
  if args.class == Array
    y = args[0][0]
    x = args[0][1]
  else
    y = args[0]
    x = args[1]
  end
  if y < 1 || y > maxy - 2
    return true
  elsif x < 1 || x > maxx - 2
    return true
  end
  return false
end
p oob?([0,8])
p oob?(0,8)
p oob?(3,8)
p oob?([2,8])

