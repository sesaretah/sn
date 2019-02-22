class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :likeable_id
      t.string :likeable_type
      t.integer :user_id
      t.string :uuid

      t.timestamps null: false
    end
    add_index :likes, :likeable_id
    add_index :likes, :likeable_type
    add_index :likes, :uuid, unique: true
  end
end
