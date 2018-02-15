class CreateAppointments < ActiveRecord::Migration[4.2]
  def change
    create_table :appointments do |t|
      t.references :item, null: false, index: true, foreign_key: true
      t.references :user, null: false, index: true, foreign_key: true
      t.string :place
      t.datetime :datetime, null: false
      t.text :memo
      t.integer :star
      t.text :review
      t.string :item_title
      t.text :item_detail
      t.integer :item_execution_time
      t.integer :item_price
      t.string :item_service
      t.string :item_available_datetime
      t.string :item_available_japan_place

      t.timestamps null: false
    end
  end
end
