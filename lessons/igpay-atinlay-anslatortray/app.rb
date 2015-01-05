require 'sinatra'
require 'pig_latin'

get '/' do
  "hello"
end

get '/translate' do
  erb :translate
end

post '/result' do
  @res = PigLatin.to_pig_latin(params)
  erb :result
end