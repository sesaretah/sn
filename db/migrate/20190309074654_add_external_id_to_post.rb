class AddExternalIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :external_id, :integer
  end
end
