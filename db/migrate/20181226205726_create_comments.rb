class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :discussion_id
      t.string :uuid
      t.text :content
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :comments, :discussion_id
    add_index :comments, :uuid, unique: true
  end
end
