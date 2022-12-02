class Calculator
  def add(a, b, *args)
    a + b + args.sum
  end

  def subtract(a, b)
    a - b
  end


end