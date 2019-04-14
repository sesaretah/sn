class AddNotifyIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :notify_id, :string
    add_index :notifications, :notify_id
  end
end
