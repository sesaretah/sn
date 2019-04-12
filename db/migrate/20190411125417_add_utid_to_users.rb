class AddUtidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :utid, :string
  end
end
