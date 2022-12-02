require_relative '../lib/calculator'


describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eq(7)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2, 3)).to eq(10)
    end
  end

  describe "#subtract" do
    it "returns the difference of two numbers" do
      calculator = Calculator.new
      expect(calculator.subtract(5, 2)).to eq(3)
    end
  end


end