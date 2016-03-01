class Community < ActiveRecord::Base
  has_many :members
  has_many :users, through: :members
  has_many :ships
  has_many :sailings
  has_many :messages
end
