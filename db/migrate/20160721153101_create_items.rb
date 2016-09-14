class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :detail
      t.integer :execution_time
      t.integer :price

      t.timestamps null: false
    end
  end
end
