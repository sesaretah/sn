class AddUuidToFollow < ActiveRecord::Migration
  def change
    add_column :follows, :uuid, :string
    add_index :follows, :uuid, unique: true
  end
end
