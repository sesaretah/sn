class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.string :followable_id
      t.string :followable_type
      t.integer :user_id
      t.integer :status

      t.timestamps null: false
    end
    add_index :follows, :followable_id
    add_index :follows, :followable_type
  end
end
