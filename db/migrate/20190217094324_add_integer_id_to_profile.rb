class AddIntegerIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :integer_id, :integer
  end
end
