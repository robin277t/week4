require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  it "testing GET/albums returns 200 and list" do
    string_response = "Surfer Rosa"

    response = get('/albums')
    expect(response.status).to eq (200)
    expect(response.body).to include (string_response)
  end
  
  it "testing POST/albums inserts new record into albums" do
    post('/albums', title: 'Voyage', release_year: 2022, artist_id: 2)
    expect(get('/albums').status).to eq (200)
    expect(get('/albums').body).to include ("Voyage")
    
  end
  

  it "testing get'/artists" do
    response = get('/artists')
    expect(response.status).to eq 200
    expect(response.body).to include ("Taylor Swift")
  end

  it "testing POST'/artists'" do
    response = post('/artists', name: 'Wild nothing', genre: 'Indie')
    expect(response.status).to eq 200
    response2 = get('/artists')
    expect(response2.body).to include ("Wild nothing")
  end


  it "get /albums/:id route html test" do
    response = get('/albums/6')
    expect(response.status).to eq 200
    expect(response.body).to include("<h1>Lover</h1>")
  end


  it "get '/albums' update to make html" do
    response = get('/albums')
    expect(response.status).to eq 200
    expect(response.body).to include("<p>Title:")
  end

  it "add links to album list print out" do
    response = get('/albums')
    expect(response.status).to eq 200
    expect(response.body).to include("<p>Title: <a href='/albums/7'>Folklore...</a></p>")
  end

  it "GET /artists/:id works" do
    response = get('/artists/3')
    expect(response.status).to eq 200
    expect(response.body).to include("<p>Taylor Swift</p>")
  end

  it "GET /artists rework with links" do
    response = get('/artists')
    expect(response.status).to eq 200
    expect(response.body).to include("<a href='/artists/3'>Taylor Swift</a>")
  end

  it "POST /newalbum adds new album" do
    response = get('/albums/newalbum')
    expect(response.status).to eq 200
    expect(response.body).to include('<form action="/albums/newalbum" method="POST">')
    
    response2 = post('/albums/newalbum', title: 'Yes' , release_year: 2022, artist_id: 3)
    expect(response2.status).to eq 200
    expect(response2.body).to include "<h2>Yes album add was successful</h2>"

    response3 = get('/albums')
    expect(response3.body).to include("<p>Title: <a href='/albums/14'>Yes...</a></p>")

  end

  it "POST /newalbum responds404 correctly" do
    response = get('/albums/newalbum')
    expect(response.status).to eq 200
    expect(response.body).to include('<form action="/albums/newalbum" method="POST">')
    
    response2 = post('/albums/newalbum', title: '' , release_year: 2022, artist_id: 3)
    expect(response2.status).to eq 400
    expect(response2.body).to eq('') 
  end

  it "GET / newartist shows form" do
    response = get('artists/newartist')
    expect(response.status).to eq 200
    expect(response.body).to include ('<form action="/artists/newartist" method="POST">')
    expect(response.body).to include ('<input type="submit" value= "press me">')
  end

  it "POST / newartist gets artist params correctly" do
    response = post('artists/newartist', name: "Me", genre: "Punk")
    expect(response.status).to eq 200
    expect(response.body).to eq("Me added to artists list")
  end

  it "POST / newartist adds artist correctly to db" do
    response = get('artists')
    expect(response.status).to eq 200
    expect(response.body).to include("<a href='/artists/7'>Me</a>")

  end



end
