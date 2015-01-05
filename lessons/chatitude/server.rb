require 'pg'
require 'sinatra'
require 'json'

require_relative 'lib/chatitude.rb'

# set :bind, '0.0.0.0'

get '/' do

  send_file 'public/index.html'
end

post '/signup' do  
  # params[:username][:password]
  headers['Content-Type'] = 'application/json'
  db = Chat::DB.connect_db
  username = params[:username]
  password = params[:password]
  new_user = Chat::DB.new_user(username,password,db)
  api_key = Chat::DB.find_api_key(new_user['id'], db)
  user_info = {'api_key' => api_key['api_key'], 'username' => username}
  return user_info.to_json
  
end

post '/signin' do
# params[:username][:password]
 headers['Content-Type'] = 'application/json' 
 db = Chat::DB.connect_db
  username = params[:username]
  password = params[:password]
  userdata = Chat::DB.find_user_byname(username,db)
  if password == userdata["password"]
     api_key = Chat::DB.find_api_key(userdata['id'], db)
     user_info = {'api_key' => api_key['api_key'], 'username' => username}
     return user_info.to_json
  end
  
end

get '/chats' do
# id, username, time, message
  headers['Content-Type'] = 'application/json'
  db = Chat::DB.connect_db
  chats = Chat::DB.getchats(db)
  chats.to_json
end

post '/chats' do
# api token message
  headers['Content-Type'] = 'application/json'
  puts params
  key = params[:apiKey]
  message = params[:message]
  db = Chat::DB.connect_db
  user_id = Chat::DB.check_api(key,db)
  puts user_id['user_id']
  if user_id
    Chat::DB.newchat(user_id['user_id'], message, db)
  end
end

