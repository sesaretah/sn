class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :mobile
      t.integer :user_id
      t.string :uuid

      t.timestamps null: false
    end
    add_index :profiles, :uuid, unique: true
  end
end
