class AddRatingToComment < ActiveRecord::Migration
  def change
    add_column :comments, :rating, :integer, null: true
  end
end
