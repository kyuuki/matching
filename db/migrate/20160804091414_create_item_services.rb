class CreateItemServices < ActiveRecord::Migration
  def change
    create_table :item_services do |t|
      t.references :item, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
