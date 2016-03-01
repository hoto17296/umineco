class Comment < ActiveRecord::Base
  belongs_to :sailing
  belongs_to :user
end
