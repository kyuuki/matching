class CreateItemAvailableDatetimes < ActiveRecord::Migration[4.2]
  def change
    create_table :item_available_datetimes do |t|
      t.references :item, index: true, foreign_key: true
      t.datetime :from
      t.datetime :to

      t.timestamps null: false
    end
  end
end
