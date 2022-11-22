def fibs
  a, b = 0, 1
  while true
    yield a
    a, b = b, a + b
  end
end

fibs do |f|
  puts f
  break if f > 8
end