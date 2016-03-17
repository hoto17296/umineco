class Member < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  belongs_to :user
  belongs_to :community
  enum type: { guest: 0, member: 1, admin: 2 }
end
