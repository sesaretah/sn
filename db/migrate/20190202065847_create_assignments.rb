class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :user_id
      t.string :role_id

      t.timestamps null: false
    end
    add_index :assignments, :role_id
  end
end
