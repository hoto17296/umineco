class Feed < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  belongs_to :community
  belongs_to :user
end
