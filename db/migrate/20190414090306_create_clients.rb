class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :user_id
      t.string :uuid

      t.timestamps null: false
    end
  end
end
