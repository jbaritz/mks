require 'sinatra'
require 'pg'

#can store db connect in separate variable like this:
helpers do
  def db_connect
    PG.conect(host: 'localhost', dbname: "airlines")
  end
end

get '/' do
  erb :index  
end

get '/airlines' do
  conn = PG.connect(host: 'localhost', dbname:'airlines')
  sql = %q[
    SELECT COUNT(DISTINCT airline_id) FROM airlines
  ]
  res = conn.exec(sql)
  @ans = res.entries
  erb :airlines
end

get '/q2' do
  conn = PG.connect(host: 'localhost', dbname:'airlines')
  sql = %q[
  SELECT carrier, COUNT(arrive_delay) as delay
  from airlines 
    WHERE arrive_delay > 0 GROUP BY carrier ORDER BY delay
  ]
  res = conn.exec(sql)
  @ans = res.entries
  erb :q2
end

get '/q3' do
  conn = PG.connect(host: 'localhost', dbname:'airlines')
  sql = %q[
  SELECT origin_city, COUNT(depart_delay) as delay
  from airlines 
  WHERE depart_delay > 0 GROUP BY origin_city ORDER BY delay
  ]
  res = conn.exec(sql)
  @ans = res.entries
  erb :q3
end

get '/q4' do
  conn = PG.connect(host: 'localhost', dbname:'airlines')
  sql = %q[
  SELECT origin_city, COUNT(arrive_delay) as delay
  from airlines 
  WHERE arrive_delay > 0 GROUP BY origin_city ORDER BY delay
  ]
  res = conn.exec(sql)
  @ans = res.entries
  erb :q4
  end

get '/q5' do  
  conn = PG.connect(host: 'localhost', dbname:'airlines')
  sql1 = %q[SELECT avg(depart_delay) FROM airlines]
  res1 = conn.exec(sql1)
  @ans1 = res1.entries[0]["avg"].to_i
  sql2 = %q[SELECT avg(arrive_delay) FROM airlines]
  res2 = conn.exec(sql2)
  @ans2 = res2.entries[0]["avg"].to_i
  @ans = (@ans1 + @ans2) / 2.to_f
  erb :q5
  end


