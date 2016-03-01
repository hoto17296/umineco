class Participant < ActiveRecord::Base
  belongs_to :sailing
  belongs_to :user
end
