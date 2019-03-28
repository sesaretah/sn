class AddCurrentRoleIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_role_id, :string
    add_index :users, :current_role_id
  end
end
