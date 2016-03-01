class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.references :sailing, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
