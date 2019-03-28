class CreateNotificationSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.integer :user_id
      t.integer :notify_streams_shares
      t.integer :notify_posts_discussions
      t.integer :notify_discussions_comments
      t.integer :notify_people_shares
      t.integer :notify_follows_likes
      t.integer :notify_authors_likes
      t.integer :notify_follows_bookmarks
      t.integer :notify_authors_bookmarks
      t.integer :notify_suggestions

      t.timestamps null: false
    end
  end
end
