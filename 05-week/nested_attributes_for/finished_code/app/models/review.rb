class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :reviewer
  accepts_nested_attributes_for :reviewer
end
