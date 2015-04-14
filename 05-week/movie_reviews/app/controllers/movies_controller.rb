class MoviesController < ApplicationController
  def index
  end

  def show
    @movie = Movie.find(params[:id])
    # @reviews = @movie.reviews.limit(10)
    @review = Review.new
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(params.require(:movie).permit(:title, :rating, :year_released, :description))

    if @movie.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end
end #end of class
