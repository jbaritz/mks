require 'sinatra'
# require 'pig_latin'


get '/translate' do
  erb :translate
  @result = PigLatin.translate(params)
end

post '/translate' do
  erb :result
end