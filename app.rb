require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra/cookies'
require './models.rb'
require "json"
require 'securerandom'

enable :sessions

set :bind, '0.0.0.0'

configure do
  enable :cross_origin
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

options "*" do
  response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end

get '/' do
    erb :index
end

post "/createhaikei/:imagelink" do
  file = @params[:file]
  photo = file[:tempfile]
  Haikei.create({
    imageLink: params[:imagelink],
    image_data: photo.read
  })
end

get "/gethaikei/:imagelink" do 
  haikei = Haikei.find_by(imageLink: params[:imagelink])
  content_type 'application/octet-stream'
  haikei.image_data
end

get "/get_all_users" do 
  users = User.all
  usernames = ""
  users.each do |user|
    usernames += "&"
    usernames += user.nickname
  end
  usernames
end

get "/get_image_id_list/:nickname" do
  chocolates = Chocolate.where(to_user_id: User.find_by(nickname: params[:nickname]).id).all
  chocolateList = ""
  chocolates.each do |c|
    chocolateList += "&"
    chocolateList += c.id.to_s
  end
  chocolateList
end

get "/getimage/:chocolate_id" do 
  chocolate = Chocolate.find_by(id: params[:chocolate_id])
  logger.info Chocolate.all
  content_type 'application/octet-stream'
  chocolate.image_data
end

post "/image/:from_user_nickname" do
    file = @params[:file]
    to_user_id = User.find_by(nickname: params[:to_user_nickname]).id
    from_user_id = User.find_by(nickname: params[:from_user_nickname]).id
    photo = file[:tempfile]
    Chocolate.create({
      from_user_id: from_user_id,
      to_user_id: to_user_id,
      image_data: photo.read
    })
end