module API
  class MoviesController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      render json: Movie.all
    end

    def show
      render json: Movie.find(params[:id])
    end

    def create
      movie = Movie.new(movie_params)

      if movie.save
        render json: movie, status: 201, location: [:api, movie]
      else
        render json: movie.errors, status: 422
      end
    end

    def update
      movie = Movie.find(params[:id])
      if movie.update(movie_params)
        head 204
      end
    end

    def destroy
      Movie.find(params[:id]).destroy
      head 204
    end

    private
    def movie_params
      params.require(:movie).permit(:title, :rating, :year, :description)
    end
  end #end class
end #end module