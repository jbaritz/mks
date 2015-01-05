def snail(lines)
  arr = []
    snailit(lines, arr)
  arr.flatten
end

def snailit(lines, arr)
  if lines.length > 0
      arr << lines[0]
       #do first line
      if lines.length > 2
        middles = lines[1..-2]
        middles.each{|line| #do right side of middles
          arr << line[-1]
          line.pop
        }
      end
      if lines.length > 1
        arr << lines[-1].reverse #do last line
      end
      if lines.length > 2
        revm = middles.reverse
        revm.each{|line| #do left side of middles
          arr << line[0]
          line.shift
      }
      end
      lines.pop
      lines.shift
      snailit(lines, arr) #recursion
  end
 arr
end

# array = [[1,2,3],
#          [4,5,6],
#          [7,8,9]]
# print snail(array) #=> [1,2,3,6,9,8,7,4,5]

# array2 = [[1,2,3],
#          [8,9,4],
#          [7,6,5]]
# print snail(array2) #=> [1,2,3,4,5,6,7,8,9]

# array = [[1,2,3,1],
#          [4,5,6,4],
#          [7,8,9,7],
#          [7,8,9,7]]
# print snail(array)

def snailalt(array)
  if array.empty? 
   [] 
  else
   array.first + snailalt(array[1..-1].transpose.reverse)
  end
end

array = [[1,2,3,1],
         [4,5,6,4],
         [7,8,9,7],
         [7,8,9,7]]
print snailalt(array)