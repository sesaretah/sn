class AddStreamIdToShares < ActiveRecord::Migration
  def change
    add_column :shares, :stream_id, :string
    add_index :shares, :stream_id
  end
end
