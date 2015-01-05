require 'sinatra'
require 'pg'
require './lib/sql'

#can store db connect in separate variable like this:
helpers do
  def db_connect
    DB.new
  end
end

get '/carriers' do
  db = db_connect

@carrier_count = db.get_airline_count
