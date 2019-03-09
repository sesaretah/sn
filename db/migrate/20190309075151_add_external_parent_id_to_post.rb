class AddExternalParentIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :external_parent_id, :integer
  end
end
