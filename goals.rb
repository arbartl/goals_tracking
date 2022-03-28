require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/content_for"
require "tilt/erubis"

require_relative "database_persistence"

configure do
  enable :sessions
  set :session_secret, 'secret'

  set :erb, :escape_html => true
  also_reload "database_persistence.rb"
end

before do
  @storage = DatabasePersistence.new
end

get "/" do
  @goals = @storage.all_goals

  erb :goals, layout: :layout
end

get "/create_goal" do
  erb :create_goal, layout: :layout
end

post "/create_goal" do
  @storage.create_goal(params)

  redirect "/"
end