def substrings(string, dictionary)
  string = string.downcase
  dictionary.reduce(Hash.new(0)) do |hash, word|
    if string.include?(word)
      hash[word] = string.scan(word).length
    end
    hash
  end 
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"] 
p substrings("Howdy partner, sit down! How's it going?", dictionary)