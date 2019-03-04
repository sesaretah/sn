class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :bookmarkable_id
      t.string :bookmarkable_type
      t.string :uuid
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :bookmarks, :uuid, unique: true
  end
end
