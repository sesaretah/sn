class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.string :stream_id
      t.string :uuid
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :questions, :stream_id
    add_index :questions, :uuid, unique: true
  end
end
