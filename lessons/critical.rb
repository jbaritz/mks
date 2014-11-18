 require 'rest-client'
response = RestClient.get("critics.api.mks.io/restaurants")
ratings = JSON.parse(response)
ratings.each {|review|
  if review["rating"].to_i == 10
    p "#{review["rating"]} - #{review["venue"]}"
  end
}
  ratings.each {|review|
  if review["rating"].to_i == 9
    p "#{review["rating"]} - #{review["venue"]}"
  end
}
ratings.each {|review|
 if review["rating"].to_i == 8
    p "#{review["rating"]} - #{review["venue"]}"
  end
}

p "Austin restaurants:"
ping = 0
ratings.each {|review|    
  if review["venue"]["Austin"]
    p review["venue"]
    ping +=1
  end
}
  if ping == 0
    p "there aren't any"
  end

response = RestClient.get("critics.api.mks.io/movie-genres")
ratings = JSON.parse(response)
ratinghash = Hash.new(0)
ratings.each {|review|
    ratinghash[review["genre"].downcase] += 1
}

ratingsorted = ratinghash.sort_by{|k,v| v}
p "Popular movie genres:"
p ratingsorted[-1]
p ratingsorted[-2]
p ratingsorted[-3]

ratingtotals = Hash.new(0)
ratings.each {|review|
  ratingtotals[review["genre"].downcase] += review["rating"].to_i
}

ratingavg = Hash.new
ratingtotals.each {|genre, total|
  ratingavg[genre] = total/ratinghash[genre]
}

ratingavgsorted = ratingavg.sort_by {|k,v| v}
p ratingavgsorted[-1]
p ratingavgsorted[-2]
p ratingavgsorted[-3]

response = RestClient.get("critics.api.mks.io/cheeses")
cheeses = JSON.parse(response)
cheeses.each {|review|
  p "#{review["cheese"]}: #{review["comment"]} --#{review["reviewer"]}"
}