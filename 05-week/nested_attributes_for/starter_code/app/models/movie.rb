class Movie < ActiveRecord::Base
  has_many :reviews

  def average_score
    # if self.reviews.count > 0
    #   sum = 0
    #   num_scores = 0

    #   self.reviews.each do |review|
    #     if review.score
    #       sum += review.score
    #       num_scores += 1
    #     end
    #   end

    #   sum/(num_scores.to_f)
    if self.reviews.count > 0
      self.reviews.where.not(score: nil).average('score')
    else
      "This movie hasn't been scored yet."
    end
  end
end
