class ReviewsController < ApplicationController
  def create
    @movie = Movie.find(params[:id])
    @review = @movie.reviews.new(review_params)
    
    @review.reviewer = Reviewer.find_or_create_by(email: params[:review][:reviewer_attributes][:email]) do |reviewer|
      reviewer.name = params[:review][:reviewer_attributes][:name]
    end

    # @reviewer = Reviewer.find_by(email: params[:review][:reviewer_attributes][:email])
    # if @reviewer
    #   @review.reviewer = @reviewer
    # else
    #   @review.reviewer = Reviewer.new(email: params[:review][:reviewer_attributes][:email], name: params[:review][:reviewer_attributes][:name])
    # end 

    @review.save
    redirect_to movie_path(@movie)
  end

  private
  def review_params
    params.require(:review).permit(:body, :score, reviewer_attributes: [:name, :email])
  end
end
