class Sailing < ActiveRecord::Base
  belongs_to :community
  belongs_to :ship
  has_many :participants
  has_many :users, through: :participants
  has_many :comments

  def participant?(user)
    return false unless user.instance_of? User
    participants.inject(false) {|v, p| v || p.user.id == user.id }
  end

  # 最大参加人数(仮)
  def max
    10
  end

end
