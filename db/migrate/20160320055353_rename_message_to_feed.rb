class RenameMessageToFeed < ActiveRecord::Migration
  def change
    drop_table :messages

    create_table :feeds do |t|
      t.string :body, null: false
      t.integer :type, default: 0, null: false, limit: 1, after: :community_id
      t.references :community, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
