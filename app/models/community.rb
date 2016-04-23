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

  def page
    YAML.load page_data
  end

  def comments
    sailing_ids = sailings.collect {|s| s.id }
    Comment.where(sailing_id: sailing_ids).order(created_at: :desc)
  end

  def comment_rating_average
    rating_list = comments.map {|c| c.rating }
    rating_list.inject(:+) / rating_list.length
  end

end
