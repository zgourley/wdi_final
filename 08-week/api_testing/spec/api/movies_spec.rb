require "rails_helper"

RSpec.describe "Movies API" do

  let(:request_headers) do
    { "Accept" => "application/json", "Content-type" => "application/json" }
  end

  describe "GET request to api/movies" do
    before do
      FactoryGirl.create_list(:movie, 10)
      get "/api/movies"
    end

    it "responds with a 200 status code" do
      expect(response).to have_http_status 200
    end

    it "returns a list of movies" do
      movies = JSON.parse(response.body)
      expect(movies.count).to eq(10)
    end
  end

  describe "GET request to api/movies/:id" do
    before do
      @movie = FactoryGirl.create(:movie)
      get "/api/movies/#{@movie.id}"
    end

    it "responds with a 200 status code" do
      expect(response).to have_http_status 200
    end

    it "returns a specific movie" do
      expect(response.body).to eq(@movie.to_json)
    end
  end

  describe "successful POST request to /api/movies" do
    before do
      movie_attributes = { "movie" => FactoryGirl.attributes_for(:movie) }.to_json
      post "/api/movies", movie_attributes, request_headers
    end

    it "responds with a 201 status code" do
      expect(response).to have_http_status 201
    end

    it "creates a new movie" do
      movie = JSON.parse(response.body)
      expect(response.location).to eq("http://www.example.com/api/movies/#{movie['id']}")
    end
  end

  describe "unsuccessful POST request to /api/movies" do
    before do
      movie_attributes = { "movie" => FactoryGirl.attributes_for(:movie, title: nil) }.to_json
      post "/api/movies", movie_attributes, request_headers
    end

    it "responds with a 422 status code" do
      expect(response).to have_http_status 422
    end

    it "responds with error messages" do
      errors = JSON.parse(response.body)
      expect(errors.count).to eq(1)
    end
  end

  describe "successful PATCH request to /api/movies" do
    before do
      @movie = FactoryGirl.create(:movie)
      movie_attributes = { "movie" => { "rating": "R" } }.to_json
      patch "/api/movies/#{@movie.id}", movie_attributes, request_headers
    end

    it "responds with a 204 status code" do
      expect(response).to have_http_status 204
    end

    it "updates a movie's attributes" do
      expect(@movie.reload.rating).to eq("R")
    end
  end

  describe "DELETE request to api/movies/:id" do
    before do
      movie = FactoryGirl.create(:movie)
      @num_movies = Movie.count
      delete "/api/movies/#{movie.id}"
    end

    it "destroys a movie" do
      expect(Movie.count).to eq(@num_movies - 1)
    end

    it "responds with a 204 status code" do
      expect(response).to have_http_status 204
    end
  end
end #end RSpec.describe block