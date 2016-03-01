class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :body, null: false
      t.references :community, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
