class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :post_id
      t.string :uuid
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :discussions, :post_id
    add_index :discussions, :uuid, unique: true
  end
end
