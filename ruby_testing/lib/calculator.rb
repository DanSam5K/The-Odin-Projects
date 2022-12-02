class Calculator
  def basic_arithmetic(a, b)
    a.to_s + b.to_s
  end

  def add(a, b, *args)
    a + b + args.sum
  end

  def subtract(a, b)
    a - b
  end

  def multiply(a, b)
    a * b
  end

  def divide(a, b)
    a / b
  end
end