class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :stream_id
      t.string :uuid
      t.string :title
      t.text :content

      t.timestamps null: false
    end
    add_index :posts, :stream_id
    add_index :posts, :uuid, unique: true
  end
end
