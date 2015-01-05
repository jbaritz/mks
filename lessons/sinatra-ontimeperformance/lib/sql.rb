class DB
attr_reader :db

def initialize
@db = PG.CONNECT(host: 'localhost', dbname: 'airlines')
end

def get_airline_count
sql = %q[
    SELECT COUNT(DISTINCT airline_id) FROM airlines
  ]
  res = conn.exec(sql)
  @ans = res.entries
  end
end