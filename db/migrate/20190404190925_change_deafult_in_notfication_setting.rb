class ChangeDeafultInNotficationSetting < ActiveRecord::Migration
  def change
    change_column :notification_settings, :notify_streams_shares, :string, :default => '000'
    change_column :notification_settings, :notify_posts_discussions, :string, :default => '000'
    change_column :notification_settings, :notify_discussions_comments, :string, :default => '000'
    change_column :notification_settings, :notify_follows_likes, :string, :default => '000'
    change_column :notification_settings, :notify_authors_likes, :string, :default => '000'
    change_column :notification_settings, :notify_follows_bookmarks, :string, :default => '000'
    change_column :notification_settings, :notify_authors_bookmarks, :string, :default => '000'
    change_column :notification_settings, :notify_suggestions, :string, :default => '000'
  end
end
