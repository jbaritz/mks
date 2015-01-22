########  1
def hundred_doors
  doors = []
  100.times {
    doors.push("closed")
  }
  count = 1
  100.times {
    doors.each_with_index{ |door, i|
        if (i+1) % count == 0
          if doors[i] == "closed"
            doors[i] = "open"
          elsif doors[i] == "open"
            doors[i] = "closed" 
          end
        end
      } #end each door loop
    count += 1
  }#end 100 loop
end

####### 2

def is_happy(n, count=0)
  if count < 1000
    bits = n.to_s.split(//)
    squares = bits.map do |d|
      d.to_i * d.to_i 
    end
    sum = squares.reduce{|sum, total| sum + total}
      # puts "Squares: #{squares} "
      # puts "Sum: #{sum} "
    
    sum == 1 ? true : is_happy(sum, count+1)
  else
    return false
  end
end

###### 3

def insert_by_predicate(pred, value, array)
  array.each_with_index do |n, i|
    
  end

end
