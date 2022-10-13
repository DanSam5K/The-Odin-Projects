# Method class implementation method
class CaecerCipher
  def initialize
      @alphabet = ('a'..'z').to_a
      @alphabet_2 = ('A'..'Z').to_a
  end

  def encode(string, key)
      string.chars.map do |char|
          if @alphabet.include?(char)
              index = @alphabet.index(char)
              @alphabet[(index + key) % @alphabet.size]
          elsif @alphabet_2.include?(char)
              index = @alphabet_2.index(char)
              @alphabet_2[(index + key) % @alphabet_2.size]
          else
              char
          end
      end.join
  end
end

cipher = CaecerCipher.new
p cipher.encode("What a string!", 5)

# Method 2
def caecer_cipher_2(string, key)
    alphabet = ('a'..'z').to_a
    alphabet_2 = ('A'..'Z').to_a
    string.chars.map do |char|
        if alphabet.include?(char)
            index = alphabet.index(char)
            alphabet[(index + key) % alphabet.size]
        elsif alphabet_2.include?(char)
            index = alphabet_2.index(char)
            alphabet_2[(index + key) % alphabet_2.size]
        else
            char
        end
    end.join
end

p caecer_cipher_2("What a string!", 5)

