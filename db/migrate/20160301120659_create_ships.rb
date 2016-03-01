class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :name, null: false
      t.references :user, index: true, foreign_key: true
      t.references :community, index: true, foreign_key: true
      t.references :marina, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
