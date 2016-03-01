class Ship < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  belongs_to :marina
  has_many :sailings
end
