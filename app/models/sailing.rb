class Sailing < ActiveRecord::Base
  belongs_to :community
  belongs_to :ship
  has_many :participants
  has_many :users, through: :participants
  has_many :comments

  validates :name, presence: true
  validates :capacity, numericality: { greater_than: 0 }
  validates :duration, presence: true

  default_scope lambda { order(duration: :asc) }
  scope :from_now, lambda { select {|sailing| sailing.duration.begin > DateTime.now } }

  def participant?(user)
    return false unless user.instance_of? User
    participants.inject(false) {|v, p| v || p.user.id == user.id }
  end

  # まだレビューを書いていないユーザー一覧
  def not_commented_users
    commented_user_ids = comments.map {|c| c.user_id }
    users.where.not(id: commented_user_ids)
  end

end
