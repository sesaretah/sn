class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school_name
      t.integer :grad_year
      t.string :country
      t.string :city
      t.string :field
      t.string :uuid

      t.timestamps null: false
    end
    add_index :educations, :uuid, unique: true
  end
end
