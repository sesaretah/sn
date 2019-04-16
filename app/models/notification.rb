class Notification < ActiveRecord::Base
  include Sender
  self.primary_key = 'uuid'

  belongs_to :user
  belongs_to :notify
  after_save :send_notification

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def send_notification
    @user = self.user

    @notify = self.notify
    case self.notification_type
    when 'Like'
      if self.ownership == 'self'
        send_by_settings(self, @user, 'notify_authors_likes')
      else
        send_by_settings(self, @user, 'notify_follows_likes')
      end
    when 'Bookmark'
      if self.ownership == 'self'
        send_by_settings(self, @user, 'notify_authors_bookmarks')
      else
        send_by_settings(self, @user, 'notify_follows_bookmarks')
      end
    when 'Share'
      if self.ownership == 'self'
        send_by_settings(self, @user, 'notify_streams_shares')
      else
        send_by_settings(self, @user, 'notify_people_shares')
      end
    when 'Follow'
      if self.ownership == 'self'
        send_by_settings(self, @user, 'notify_authors_followers')
      end
    end

  end




  def id
    self.uuid
  end

  def self.find(uuid)
    Notification.find_by_uuid(uuid)
  end
end
