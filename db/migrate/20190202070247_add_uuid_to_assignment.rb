class AddUuidToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :uuid, :string
    add_index :assignments, :uuid, unique: true
  end
end
