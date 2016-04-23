class Participant < ActiveRecord::Base
  belongs_to :sailing
  belongs_to :user

  validates :sailing, presence: true
  validates :user, presence: true
end
