class AddReviewerIdToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :reviewer, index: true
    add_foreign_key :reviews, :reviewers
  end
end
