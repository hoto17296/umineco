class AddTypeToMember < ActiveRecord::Migration
  def change
    add_column :members, :type, :integer, default: 0, null: false, limit: 1, after: :community_id
  end
end
