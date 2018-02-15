class CreateItemServices < ActiveRecord::Migration[4.2]
  def change
    create_table :item_services do |t|
      t.references :item, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
