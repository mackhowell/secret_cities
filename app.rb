require 'sinatra'
require 'dm-core'
#require 'json'
DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class AnonPost
  include DataMapper::Resource
  property :id, Serial
  property :username, String
  property :secret, String
  property :lat, Float
  property :lng, Float
  property :created_at, DateTime
end

DataMapper.finalize


get '/board' do
  @posts = AnonPost.all
  erb :board
end

get '/' do
  erb :map
end

get '/secretmap' do
  erb :fakesecretmap
end

get '/savePost' do

  new_post = AnonPost.new
  new_post.username = params[:username]
  new_post.secret = params[:secret]
  new_post.lat = params[:lat]
  new_post.lng = params[:lng]
  new_post.created_at = DateTime.now
  
  if (new_post.save)
    @message = "Your post was saved!"
  else
    @message = "Uh oh! Post was not saved."
  end
  
  erb :savePost
end

#get '/allmap' do
#  @anonposts = AnonPost.all
#  @anonposts[0].attributes.to_json
#end

get '/about' do
  erb :about
end
