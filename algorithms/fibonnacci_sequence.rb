# def fibs
#   a, b = 0, 1
#   while true
#     yield a
#     a, b = b, a + b
#   end
# end

# fibs do |f|
#   puts f
#   break if f > 8
# end

def fibs(n)
  if n < 2
    n
  else
    fibs(n-1) + fibs(n-2)
  end
end

fibs(10)