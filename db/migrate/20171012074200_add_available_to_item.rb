class AddAvailableToItem < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :available, :boolean, null: false, default: true, after: :price
    add_index :items, :available
  end
end
