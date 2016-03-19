class AddDateToSailing < ActiveRecord::Migration
  def change
    add_column :sailings, :duration, :tsrange, after: :ship_id
    add_column :sailings, :invite_duration, :tsrange, after: :duration
    remove_column :sailings, :date, :datetime
  end
end
