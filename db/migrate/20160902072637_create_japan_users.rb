class CreateJapanUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :japan_users do |t|
      t.references :user, index: true, foreign_key: true
      t.string :first_name_kana
      t.string :last_name_kana
      t.references :japan_prefecture, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
