require 'sinatra'
require_relative './lib/DB.rb'

get '/' do
  send_file 'public/index.html'
end