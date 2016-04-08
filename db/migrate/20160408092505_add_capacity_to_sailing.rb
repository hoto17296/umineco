class AddCapacityToSailing < ActiveRecord::Migration
  def change
    add_column :sailings, :capacity, :integer, null: false, default: 5
  end
end
