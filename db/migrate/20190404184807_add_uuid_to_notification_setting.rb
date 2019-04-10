class AddUuidToNotificationSetting < ActiveRecord::Migration
  def change
    add_column :notification_settings, :uuid, :string
    add_index :notification_settings, :uuid
  end
end
