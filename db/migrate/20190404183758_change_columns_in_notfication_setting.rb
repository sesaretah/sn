class ChangeColumnsInNotficationSetting < ActiveRecord::Migration
  def change
    change_column :notification_settings, :notify_streams_shares, :string
    change_column :notification_settings, :notify_posts_discussions, :string
    change_column :notification_settings, :notify_discussions_comments, :string
    change_column :notification_settings, :notify_follows_likes, :string
    change_column :notification_settings, :notify_authors_likes, :string
    change_column :notification_settings, :notify_follows_bookmarks, :string
    change_column :notification_settings, :notify_authors_bookmarks, :string
    change_column :notification_settings, :notify_suggestions, :string
  end
end
