class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :uuid
      t.integer :user_id
      t.string :title
      t.string :subdomain

      t.timestamps null: false
    end
    add_index :streams, :uuid, unique: true
  end
end
