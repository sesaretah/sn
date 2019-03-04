class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.text :abstract
      t.string :link
      t.string :uuid
      t.integer :external_id
      t.string :provider

      t.timestamps null: false
    end
    add_index :publications, :uuid
  end
end
