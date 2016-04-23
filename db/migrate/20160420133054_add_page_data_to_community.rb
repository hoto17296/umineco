class AddPageDataToCommunity < ActiveRecord::Migration
  def change
    add_column :communities, :page_data, :text, null: true
  end
end
