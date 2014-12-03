require 'sinatra'
require 'rest-client'

get '/' do
  erb :index
end

get '/movies' do
   url = "movies.api.mks.io/movies"
   temp = RestClient.get(url)
   @movies = JSON.parse(temp)
  erb :"movies/index"
end

get '/actors' do
   url = "movies.api.mks.io/actors"
   temp = RestClient.get(url)
   @actors = JSON.parse(temp)
  erb :"actors/index"
end

get '/movies/:id' do
  movid = params[:id] 
  url = "movies.api.mks.io/movies/" + movid.to_s # grab movie title
  temp = RestClient.get(url)
  movie = JSON.parse(temp)
  @currentmov = movie["title"]
  url = "movies.api.mks.io/movies/" + movid.to_s + "/actors" #grab actors
  temp = RestClient.get(url)
  @movactors = JSON.parse(temp)
  erb :"movies/castlist"
end

get '/actors/:id' do
  actid = params[:id]
  url = "movies.api.mks.io/actors/" + actid.to_s # grab movie title
  temp = RestClient.get(url)
  movie = JSON.parse(temp)
  @actorname = movie["name"]
  url = "movies.api.mks.io/actors/" + actid.to_s + "/movies" #grab actors
  temp = RestClient.get(url)
  @actorfilms = JSON.parse(temp)
  erb :"actors/actor-films"
end