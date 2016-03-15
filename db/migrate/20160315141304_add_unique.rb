class AddUnique < ActiveRecord::Migration
  def change
    add_index :members, [ :user_id, :community_id ], unique: true
    add_index :participants, [ :user_id, :sailing_id ], unique: true
  end
end
