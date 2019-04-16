class AddIntegerIdToStream < ActiveRecord::Migration
  def change
    add_column :streams, :integer_id, :integer
  end
end
