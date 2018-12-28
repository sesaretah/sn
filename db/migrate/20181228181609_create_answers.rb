class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :content
      t.string :uuid
      t.string :question_id

      t.timestamps null: false
    end
    add_index :answers, :uuid, unique: true
    add_index :answers, :question_id
  end
end
