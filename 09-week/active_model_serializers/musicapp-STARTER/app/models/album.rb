class Album < ActiveRecord::Base
  belongs_to :band
  belongs_to :genre
  has_many :songs
end
