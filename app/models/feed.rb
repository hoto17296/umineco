class Feed < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  belongs_to :community
  belongs_to :user
  enum type: {
    post: 0,         # 通常投稿
    interest: 1,     # 興味あります
    another_time: 2, # 別日程なら参加したい
  }
end
