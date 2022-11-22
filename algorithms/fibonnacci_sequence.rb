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

def fibs_rec(n)
  if n < 2
    n
  else
    fibs_rec(n-1) + fibs_rec(n-2)
  end
end

fibs(10)