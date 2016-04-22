class Comment < ActiveRecord::Base
  belongs_to :sailing
  belongs_to :user

  validates :user, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than: 5 }
  validates :body, presence: true
end
