class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.string :shareable_id
      t.string :shareable_type
      t.integer :user_id
      t.string :uuid

      t.timestamps null: false
    end
    add_index :shares, :shareable_id
    add_index :shares, :shareable_type
    add_index :shares, :uuid, unique: true
  end
end
