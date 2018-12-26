class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :uploadable_id
      t.string :uploadable_type
      t.string :attachment_type
      t.string :uuid

      t.timestamps null: false
    end
    add_index :uploads, :uploadable_id
    add_index :uploads, :uploadable_type
    add_index :uploads, :attachment_type
    add_index :uploads, :uuid, unique: true
  end
end
