class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :uuid
      t.string :title
      t.text :description

      t.timestamps null: false
    end
    add_index :roles, :uuid, unique: true
  end
end
