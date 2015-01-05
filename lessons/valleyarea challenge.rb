def valleys(array)
  valley = false
  res = []
  temp = [] 
  array.each_with_index{|a, i|
   if i == 0
      temp.push(a) #first num is always current max
   elsif a < array[i-1] #if dip
      temp.push(a) #log
      valley = true
   elsif a == array[i-1] #if equal
      temp.push(a) #log
   elsif a > array[i-1] #if increases
    if valley #in valley
        if array[i+1] #if a is not the last number
          if a < array[i+1] #if continues to increase (not last max)
            temp.push(a) #just log a
          elsif a > array[i+1] #if last max
            if a < temp[0]
              temp.push(a)
              b = areacalc(temp)
              res.push(b)
              temp = [a]
              valley = false
            elsif a > temp[0]
              b = areacalc(temp)
              res.push(b)
              temp = [a]
              valley = false
            end
          end
        else #if a is the last number
           if a < temp[0]
              temp.push(a)
              print temp
              b = areacalc(temp)
              res.push(b)
              temp = [a]
              valley = false
           elsif a > temp[0]
            print temp
              b = areacalc(temp)
              res.push(b)
              temp = [a]
              valley = false
           end
        end
    else#increasing but without valley
      temp = [a]
      valley = false
    end
   end
  }
  res.reduce(0){|s , a| s + a}
end

def areacalc(temp) #takes valley array
  area = 0
  if temp[0] >= temp[-1] #if first max is greater than last max height is last max
   temp.each_with_index{|a, i|
    if !(i==0||i==-1)
      area += (temp[-1] - a)
    end 
    }  
  elsif temp[0] < temp[-1]
   temp.each_with_index{|a, i|
    if !(i==0||i==-1)
      area += (temp[0] - a)
    end 
   }
  end 
  return area
end

a = [2,3,1,3,5,2,2,4,3]
puts valleys(a)
b = [4,2,1,2,4,6,8]
puts valleys(b)