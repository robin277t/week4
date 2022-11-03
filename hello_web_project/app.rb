require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return "hello out there again"
  end

  get '/hello' do
    @name = params[:name]
    return erb(:index)
  end

  get '/names' do
    params[:name]
  end

  post '/' do
    return "what are you posting?"
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]
    return "Hello #{name}, you wrote #{message}"
  end

  post '/sort-names' do
    names = params[:names]
    return names.split(",").sort.join(",")
  end


end