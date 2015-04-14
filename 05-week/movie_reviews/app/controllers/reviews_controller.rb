class ReviewsController < ApplicationController
  def create
    @movie = Movie.find(params[:id])
    @review = @movie.reviews.new(params.require(:review).permit(:body, :score))
    @review.save
    redirect_to movie_path(@movie)
  end
end
