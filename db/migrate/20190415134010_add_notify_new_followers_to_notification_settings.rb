class AddNotifyNewFollowersToNotificationSettings < ActiveRecord::Migration
  def change
    add_column :notification_settings, :notify_new_followers, :string, :default => '000'
  end
end
