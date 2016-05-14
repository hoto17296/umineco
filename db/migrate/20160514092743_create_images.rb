# Postgre の uuid-ossp Extention を有効にする必要あり
class CreateImages < ActiveRecord::Migration
  def change
    create_table :images, id: :uuid do |t|
      t.references :user, index: true, foreign_key: true, null: false

      t.string :filename
      t.string :filetype
      t.integer :filesize

      t.timestamps null: false
    end
  end
end
