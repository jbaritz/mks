require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'
require 'pry-byebug'
# require 'rack-flash'
# require_relative 'lib/petshop.rb'
require_relative 'config/environments.rb'
require_relative 'lib/DB.rb'


configure do
    enable :sessions
  end

 before do
    if session[:user_id]
      user_id = session[:user_id]
      user = User.find(user_id)
      @current_user = user.attributes
     #  usercats = Adoption.where(["user_id= ?",user_id])
     #  userdogs = Adoption.where(["user_id=?",user_id])
     #  @current_user['cats'] = usercats
     #  @current_user['dogs'] = userdogs
     # puts @current_user

    end
  end

get '/' do

  erb :index
end

get '/logout' do
    session.delete('user_id')
    redirect to '/'
end

get '/shops' do
  headers['Content-Type'] = 'application/json'
  shops = Shop.all
  s = shops.map do |x|
    attrs = x.attributes
    attrs.delete(nil)
    attrs
  end
  s.to_json
end

post '/signin' do
  headers['Content-Type'] = 'application/json'
  params = JSON.parse request.body.read
  username = params['username']
  password = params['password']
  usersearch = User.find_by(username: username)
  if password == usersearch["password"]
    session[:user_id] = usersearch['id']
    usersearch.to_json
  else
    status 401
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do
  puts params
  User.create!(username: params[:username], password: params[:password])
  redirect to '/'
end

 # # # #
# Cats #
# # # #
get '/shops/:id/cats' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  cats = Cat.where("shop_id = ?",id.to_i)
    s = cats.map do |x|
    attrs = x.attributes
    attrs.delete(nil)
    attrs
  end
  res = PetShop::DB.map_cats(s)
  res.to_json

end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  user_id = session[:user_id]
  cat = Cat.find(id)
  cat['adopted'] = true
  cat.save

end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  dogs = Dog.where("shop_id = ?",id.to_i)
    s = dogs.map do |x|
    attrs = x.attributes
    attrs.delete(nil)
    attrs
  end
  res = PetShop::DB.map_dogs(s)
  res.to_json
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  user_id = session[:user_id]
   # db = PetShop::Database.dbconnect
   # PetShop::DB.adopt_dog(db, id, user_id)
end



# class PetShop::Server < Sinatra::Application

#   set :bind, '0.0.0.0' # This is needed for Vagrant

#   configure do
#     enable :sessions
#     # use Rack::Flash
#   end

#   before do
#     @db = PetShop.create_db_connection 'petshop_db'
#     if session[:user_id]
#       owner_id = session['user_id']
#       @current_user = PetShop::OwnerRepo.find @db, owner_id
#       @current_user['cats'] = PetShop::CatRepo.find_all_by_owner(@db, @current_user['id'])
#       @current_user['dogs'] = PetShop::DogRepo.find_all_by_owner(@db, @current_user['id'])
#       @current_user
#     else
#       #@current_user = $sample_user
#     end
#   end

#   # #
#   # This is our only html view...
#   #
#   get '/' do
#     erb :index
#   end

#   # #
#   # ...the rest are JSON endpoints
#   #
#   get '/shops' do
#     headers['Content-Type'] = 'application/json'
#     shops = PetShop::ShopRepo.all(@db).to_json
#   end

#   post '/signin' do
#     params = JSON.parse request.body.read

#     username = params['username']
#     password = params['password']

#     # TODO: Grab user by username from database and check password
#     owner = PetShop::OwnerRepo.find_by_name(@db, username)
#     # user = { 'username' => 'alice', 'password' => '123' }

#     # Validate credentials Valid
#     if !owner.nil? && password == owner['password']
#       headers['Content-Type'] = 'application/json'

#       # TODO: Return all pets adopted by this user
#       owner['cats'] = PetShop::CatRepo.find_all_by_owner(@db, owner['id'])
#       owner['dogs'] = PetShop::DogRepo.find_all_by_owner(@db, owner['id'])

#       # TODO: Set session[:user_id] so the server will remember this user has logged in
#       session['user_id'] = owner['id']

#       owner.to_json
#     else
#       status 401
#     end
#   end

#    # # # #
#   # Cats #
#   # # # #
#   get '/shops/:id/cats' do
#     headers['Content-Type'] = 'application/json'
#     id = params[:id]
#     # TODO: Grab from database instead
#     # RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/cats")

#     PetShop::CatRepo.find_all_by_shop(@db, id).to_json
#   end

#   put '/shops/:shopid/cats/:id/adopt' do
#     headers['Content-Type'] = 'application/json'
#     # shopid = params[:shopid]
#     id = params[:id]
#     # Grab Cat data from database

#     owner = PetShop::OwnerRepo.find(@db, @current_user['id'])
#     cat = PetShop::CatRepo.save(@db, {'id' => id, 'owner_id' => owner['id'], 'adopted' => 'true'}).to_json
#   end


#    # # # #
#   # Dogs #
#   # # # #
#   get '/shops/:id/dogs' do
#     headers['Content-Type'] = 'application/json'
#     id = params[:id]
#     dogs = PetShop::DogRepo.find_all_by_shop(@db, id).to_json
#   end

#   put '/shops/:shopid/dogs/:id/adopt' do
#     headers['Content-Type'] = 'application/json'
#     shopid = params[:shopid]
#     id = params[:id]
    
#     owner = PetShop::OwnerRepo.find(@db, @current_user['id'])
#     cat = PetShop::DogRepo.save(@db, {'id' => id, 'owner_id' => owner['id'], 'adopted' => 'true'}).to_json

#   end


#   $sample_user = {
#     id: 999,
#     username: 'anonymous',
#     cats: [
#       { shopid: 1, name: "NaN Cat", imageurl: "http://i.imgur.com/TOEskNX.jpg", adopted: 'true', id: 44 },
#       { shopid: 8, name: "Meowzer", imageurl: "http://www.randomkittengenerator.com/images/cats/rotator.php", id: 8, adopted: 'true' }
#     ],
#     dogs: [
#       { shopid: 1, name: "Leaf Pup", imageurl: "http://i.imgur.com/kuSHji2.jpg", happiness: 2, id: 2, adopted: 'true' }
#     ]
#   }
# end