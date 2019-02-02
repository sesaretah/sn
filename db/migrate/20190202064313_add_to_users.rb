class AddToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string
    add_column :users, :username, :string
    add_column :users, :phone_number, :string
    add_column :users, :mobile, :string
  end
  #add_index :users, :username, unique: true
end
