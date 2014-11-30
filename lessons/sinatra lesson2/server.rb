require 'rubygems'
require 'sinatra'
require 'pry'

get '/welcome/:name' do
  puts params
  erb :welcome
end

get '/say/*/to/*' do
  puts params
  erb :say
end

get '/eva' do
  erb :eva
end

post '/eva' do
  puts params
  @answer = params["answer"]
  erb :eva
end

get '/dog-registration' do
  erb :dog-registration
  end

get '/dog-registration-results' do
  erb :dog-registration-results
end