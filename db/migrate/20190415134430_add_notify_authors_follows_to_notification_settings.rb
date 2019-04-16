class AddNotifyAuthorsFollowsToNotificationSettings < ActiveRecord::Migration
  def change
    add_column :notification_settings, :notify_authors_followers, :string, :default => '000'
  end
end
