class CreateJapanCities < ActiveRecord::Migration[4.2]
  def change
    create_table :japan_cities do |t|
      t.references :japan_prefecture, index: true, foreign_key: true
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
