class Todo < ActiveRecord::Base
  validates :task, presence: true
end
