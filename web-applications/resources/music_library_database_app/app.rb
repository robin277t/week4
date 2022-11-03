# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/' do
    return 'home'
  end

  get '/albums' do
    albums = AlbumRepository.new
    @album_array = albums.all
    erb(:index2)
  end

  post '/albums' do
    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]
    albums = AlbumRepository.new 
    albums.create(album)
  end

  post '/artists' do
    artistlist = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]
    artistlist.create(new_artist)
    return nil
  end

  get /\/albums\/([\d]+)/ do |urlid| 
    albumlist = AlbumRepository.new
    artistlist = ArtistRepository.new
    @chosenalbum = albumlist.find(urlid)
    @artistname = artistlist.find(@chosenalbum.artist_id).name
    return erb(:index)

  end

  get /\/artists\/([\d]+)/ do |id| 
    artistlist = ArtistRepository.new
    @chosen_artist = artistlist.find(id)
    return erb(:artist)
  end

  get '/artists' do
    artistslist = ArtistRepository.new
    @artist = artistslist.all
    erb(:artist_list)
  end

  get '/albums/newalbum' do
    erb(:newform)
  end



  post '/albums/newalbum' do
    if params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil
      status 400
      return ''
    elsif params[:title] == "" || params[:release_year] == "" || params[:artist_id] == ""
      status 400
      return ''
    end

      @new_alb = Album.new
      @new_alb.title = params[:title]
      @new_alb.release_year = params[:release_year]
      @new_alb.artist_id = params[:artist_id]
      newrepo = AlbumRepository.new.create(@new_alb)
      erb(:addsuccess)
  end

  get '/artists/newartist' do
    erb(:newform2)
  end

  post '/artists/newartist' do
    if params[:name] == "" || params[:name] == nil || params[:genre] == "" || params[:genre] == nil 
      status 400
      return 'oops, incorrect data'
    end
    @artist = Artist.new
    @artist.name = params[:name]
    @artist.genre = params[:genre]
    artistsrepo = ArtistRepository.new.create(@artist)
    return "#{@artist.name} added to artists list"
  end

end



