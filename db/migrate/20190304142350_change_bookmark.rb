class ChangeBookmark < ActiveRecord::Migration
  def change
    change_column :bookmarks, :bookmarkable_id, :string
    add_index :bookmarks, :bookmarkable_id
    add_index :bookmarks, :bookmarkable_type
  end
end
