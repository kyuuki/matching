class CreateItemAvailableJapanPlaces < ActiveRecord::Migration[4.2]
  def change
    create_table :item_available_japan_places do |t|
      t.references :item, index: true, foreign_key: true
      t.references :japan_city, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
