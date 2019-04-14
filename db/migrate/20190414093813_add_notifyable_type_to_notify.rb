class AddNotifyableTypeToNotify < ActiveRecord::Migration
  def change
    add_column :notifies, :notifyable_type, :string
    add_index :notifies, :notifyable_type
  end
end
