class CreateAccessControls < ActiveRecord::Migration
  def change
    create_table :access_controls do |t|
      t.string :uuid
      t.string :role_id
      t.boolean :ability_to_create_stream
      t.boolean :ability_to_create_discussion
      t.boolean :ability_to_comment
      t.boolean :ability_to_create_question
      t.boolean :ability_to_create_answer

      t.timestamps null: false
    end
    add_index :access_controls, :uuid, unique: true
    add_index :access_controls, :role_id
  end
end
