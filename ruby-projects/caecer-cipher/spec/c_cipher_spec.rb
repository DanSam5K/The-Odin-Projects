require './c-cipher'

RSpec.describe CaecerCipher do
  describe ".encode" do
    it "returns the encoded string" do
      expect(subject.encode("What a string!", 5)).to eq("Bmfy f xywnsl!")
    end

    it "returns the encoded string" do
      expect(subject.encode("What a string!", 10)).to eq("Grkd k cdbsxq!")
    end

    it "returns all small letters in the alphabet" do
      expect(subject.alphabet).to eq(('a'..'z').to_a)
    end

    it "returns all capital letters in the alphabet" do
      expect(subject.alphabet_2).to eq(('A'..'Z').to_a)
    end

    it "returns alphabet size to equal 26" do
      expect(subject.alphabet.size).to eq(26)
    end
  end

end