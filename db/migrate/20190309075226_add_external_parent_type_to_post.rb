class AddExternalParentTypeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :external_parent_type, :string
  end
end
