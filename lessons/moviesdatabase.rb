require 'pg'
require 'rest-client'
require 'json'

#   Column  |  Type   | Modifiers 
# ----------+---------+-----------
#  movie_id | integer | 
#  actor_id | integer | 

#/movies: id, title
#/movies/:movieId/actors: name, movieId, id
#/actors: name, id
#/actors/:movieId/movies: title, actorId, id

class Database
  def initialize
  @db = PG.connect(host: 'localhost', dbname:'movie_db')
  end 

  def build_db #get list of movies, build movie list, get actor list and build actors table
    url = "movies.api.mks.io/movies"
    temp = RestClient.get(url)
    movies = JSON.parse(temp)
    movies.each {|movie|
      sql = %q[
        INSERT INTO movies (title, id)
        VALUES ($1, $2)
            ]
    @db.exec_params(sql, [movie["title"], movie["id"]])
      }
    url = "movies.api.mks.io/actors"
    temp = RestClient.get(url)
    actors = JSON.parse(temp)
    actors.each {|a|
      sql = %q[
        INSERT INTO actors (name, id)
        VALUES ($1, $2)
            ]
    @db.exec_params(sql, [a["name"], a["id"]])
      }
    url = "movies.api.mks.io/movies/"
    temp = RestClient.get(url)
    movies = JSON.parse(temp)
    movies.each {|m|
      url = "movies.api.mks.io/movies/" + m["id"].to_s + "/actors/"
      temp = RestClient.get(url)
      cast = JSON.parse(temp)
      cast.each {|a|
      sql = %q[
        INSERT INTO castlist (movie_id, actor_id)
        VALUES ($1, $2)
            ]
    @db.exec_params(sql, [a["movieId"], a["id"]])
           } #end each movie cast
      }#end each movie
  end

  def all_actors
    sql = %q[
        SELECT name FROM actors ORDER BY name;
            ]
    success = @db.exec(sql)
    success.entries.each{|e|
      puts e["name"]
      }
  end

  def all_movies
    sql = %q[
        SELECT title FROM movies ORDER BY title;
            ]
    success = @db.exec(sql)
    success.entries.each{|e|
      puts e["title"]
      }
  end

  def freq_actors
    sql = %q[
      SELECT a.name, COUNT(*) AS appearances FROM castlist c
      JOIN actors a
      ON c.actor_id = a.id
      GROUP BY a.name
      ORDER BY appearances
      ]
    success = @db.exec(sql)
    e = success.entries[-3..-1]
   puts "Actor               | Appearances"
   puts "-----------------------"
  e.each{|e|
    whitespace = 20 - e["name"].length 
    print e["name"]
    whitespace.times{print " "}
    print "| #{e["appearances"]}"
    puts ""
    }
  end

  def moviecast(title)
    sql = %q[
      SELECT a.name FROM castlist c
      JOIN actors a
      ON c.actor_id = a.id
      JOIN movies m
      ON c.movie_id = m.id
      WHERE m.title like $1   
      ]
    success = @db.exec_params(sql, [title])
    e = success.entries
    e.each {|e|
        puts e["name"]
    }
  end

  def actormovies(actor)
    sql = %q[
      SELECT id
      FROM actors
      WHERE name like $1
    ]
    temp = @db.exec_params(sql, [actor])
    actid =  temp.entries[0]["id"]
    sql = %q[
      SELECT m.title 
      FROM movies m
      JOIN castlist c
      ON c.movie_id = m.id
      WHERE c.actor_id = $1
    ]
    temp = @db.exec_params(sql, [actid])
    films = temp.entries
    films.each {|film|
      puts film["title"]
    }
  end

  def costars(actor)
    #find all movies an actor was in, then list other actors in those movies
  sql = %q[
      SELECT id
      FROM actors
      WHERE name like $1
    ]
    temp = @db.exec_params(sql, [actor])
    actid =  temp.entries[0]["id"]
    sql = %q[
      SELECT m.title 
      FROM movies m
      JOIN castlist c
      ON c.movie_id = m.id
      WHERE c.actor_id = $1
    ]
    temp = @db.exec_params(sql, [actid])
    films = temp.entries
    films.each {|film|
      sql = %q[
      SELECT a.name FROM castlist c
      JOIN actors a
      ON c.actor_id = a.id
      JOIN movies m
      ON c.movie_id = m.id
      WHERE m.title like $1   
      ]
    success = @db.exec_params(sql, [film["title"]])
    e = success.entries
    e.each {|e|
      if e["name"] != actor
        puts e["name"]
      end
      }
    }    
  end

  def comovies(actor1, actor2)
     sql = %q[
      SELECT id
      FROM actors
      WHERE name like $1
    ]
    temp = @db.exec_params(sql, [actor1])
    actid1 =  temp.entries[0]["id"]
       sql = %q[
      SELECT id
      FROM actors
      WHERE name like $1
    ]
    temp = @db.exec_params(sql, [actor2])
    actid2 =  temp.entries[0]["id"]
    sql = %q[
      select m.title 
      from movies m
      join castlist c
      on c.movie_id = m.id
      where c.actor_id = $1
      intersect
       select m.title 
      from movies m
      join castlist c
      on c.movie_id = m.id
      where c.actor_id = $2
      ]
    result = @db.exec_params(sql, [actid1, actid2])
    films = result.entries
    films.each {|film|
      puts film["title"]}
  end


end #end of class

class CLIENT
  def self.command_list
    puts "1. list all movies"
    puts "2. list all actors"
    puts "3. all actors in a movie"
    puts "4. find all movies an actor was in by ID or name"
    puts "5. find all costars of an actor"
  end

  def self.start
    movies = Database.new
    puts "SELECT AN OPTION:"
    command_list
    input = gets.chomp
    case input
    when "1"
      movies.all_movies
    when "2"
      movies.all_actors
    when "3"
      puts "What is the name of the movie you are looking for?"
      name = gets.chomp
      movies.moviecast(name)
    when "4"
      puts "What actor do you want to find the filmography of?"
      name = gets.chomp
      movies.actormovies(name)
    when "5"
      puts "What actor do you want to find the costars of?"
      name = gets.chomp
      movies.costars(name)
    end # end case
  end # end start
end # end client



CLIENT.start
