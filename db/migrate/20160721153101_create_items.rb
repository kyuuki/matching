class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :execution_time
      t.string :place
      t.references :service, index: true, foreign_key: true
      t.string :name
      t.text :detail
      t.integer :price

      t.timestamps null: false
    end
  end
end
