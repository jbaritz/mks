require 'pg'
require 'rest-client'
require 'json'

#/movies: id, title
#/movies/:movieId/actors: name, movieId, id
#/actors: name, id
#/actors/:movieId/movies: title, actorId, id

class Database
  def initialize
  @db = PG.connect(host: 'localhost', dbname:'movie_db')
  end 

  def build_db #get list of movies, build movie list, get actor list and build actors table
    # url = "movies.api.mks.io/movies"
    # temp = RestClient.get(url)
    # movies = JSON.parse(temp)
    # movies.each {|movie|
    #   sql = %q[
    #     INSERT INTO movies (title, id)
    #     VALUES ($1, $2)
    #         ]
    # @db.exec_params(sql, [movie["title"], movie["id"]])
    #   }
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

  end
end #end of class

 #iterate through each url and get list of actors
movies = Database.new
movies.build_db