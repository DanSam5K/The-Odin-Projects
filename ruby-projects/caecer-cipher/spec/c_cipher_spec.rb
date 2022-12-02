require './c-cipher'

RSpec.describe CaecerCipher do
  describe ".encode" do
    it "returns the encoded string" do
      expect(subject.encode("What a string!", 5)).to eq("Bmfy f xywnsl!")
    end

    it "returns the encoded string" do
      expect(subject.encode("What a string!", 10)).to eq("Grkd k cdbsxq!")
    end
  end


end