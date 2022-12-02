require './lib/calculator'


describe Calculator do

  describe ".basic_arithmetic" do
    it "adds two strings" do
      expect(subject.basic_arithmetic("a", "b")).to eq("ab")
    end
  end

  describe "#add" do
    it "returns the sum of two numbers" do
      expect(subject.add(5, 2)).to eq(7)
    end

    it "returns the sum of more than two numbers" do
      expect(subject.add(5, 2, 3)).to eq(10)
    end
  end

  describe "#subtract" do
    it "returns the difference of two numbers" do
      expect(subject.subtract(5, 2)).to eq(3)
    end
  end

  describe "#multiply" do
    it "returns the product of two numbers" do
      # subject = subject.new
      expect(subject.multiply(5, 2)).to eq(10)
    end
  end

  describe "#divide" do
    it "returns the quotient of two numbers" do
      expect(subject.divide(6, 2)).to eq(3)
    end
  end


end