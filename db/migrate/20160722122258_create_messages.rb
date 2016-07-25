class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender, index: true #, foreign_key: true
      t.references :receiver, index: true #, foreign_key: true
      t.text :body

      t.timestamps null: false

      t.index [:sender_id, :receiver_id]
    end
  end
end
