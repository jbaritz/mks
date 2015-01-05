# def nestedWordCount(wordList) 
#  # hash = {};
#  # wordList.each{ |word|
#  #  w = word
#  #  wordList.each{|word2|
#  #    if w != word2
#  #      if (w.include? word2)
#  #         if hash[w]
#  #          hash[w] +=1
#  #        else 
#  #          hash[w] = 1
#  #        end
#  #      end
#  #    end
#  #  } 
#  #  }
#  #  return hash.max_by{|k,v| v}
# end

# a = []
# f = File.open("enable1.txt", "r")
# f.each_line do |line|
#   a.push(line)
# end
# f.close
# nestedWordCount(a)


words = File.read('enable1.txt').split
valid = Hash[words.zip [1].cycle]

long_words = words.select{|w| w.size > 12} 
puts long_words.max_by { |w| 
  n = 0
  (0..w.size - 2).each do |s|
    (2..w.size - s).each do |e|
    n += 1 if valid[w[s, e]]
    end
  end
  n
}

