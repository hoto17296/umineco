class CreateSailings < ActiveRecord::Migration
  def change
    create_table :sailings do |t|
      t.string :name
      t.datetime :date
      t.references :community, index: true, foreign_key: true
      t.references :ship, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
