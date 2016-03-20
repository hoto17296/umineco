class Community < ActiveRecord::Base
  has_many :members
  has_many :users, through: :members
  has_many :ships
  has_many :sailings
  has_many :feeds

  def member?(user)
    return false if user.blank?
    members.where(user: user).present?
  end

  def add_member(user, type=:guest)
    return if member? user
    member = Member.new( user: user, type: type )
    members << member
    save
  end

end
