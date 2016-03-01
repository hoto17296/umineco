class Sailing < ActiveRecord::Base
  belongs_to :community
  belongs_to :ship
  has_many :participants
  has_many :users, through: :participants
  has_many :comments
end
