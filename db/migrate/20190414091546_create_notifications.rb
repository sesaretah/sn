class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.integer :status

      t.timestamps null: false
    end
  end
end
