require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "./lib/ingredient"
require "./lib/recipe"
require "./lib/tag"
require "pry"

get "/" do
  erb :index
end
