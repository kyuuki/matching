class AddColumnsToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :account_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :sex, :integer
    add_column :users, :birthday, :date
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :address3, :string
    add_column :users, :phone, :string
    add_column :users, :phone_mobile, :string
    add_column :users, :profile, :text
    add_column :users, :profile_image, :string
  end
end
