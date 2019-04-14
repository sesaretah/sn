class CreateNotifies < ActiveRecord::Migration
  def change
    create_table :notifies do |t|
      t.string :notifyable_id
      t.string :notfiyable_type

      t.timestamps null: false
    end
    add_index :notifies, :notifyable_id
    add_index :notifies, :notfiyable_type
  end
end
