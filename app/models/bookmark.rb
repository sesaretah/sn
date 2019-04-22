class Bookmark < ActiveRecord::Base
  self.primary_key = 'uuid'

  belongs_to :bookmarkable, :polymorphic => true
  belongs_to :stream, :class_name => "Bookmark", :foreign_key => "bookmarke_id"

  belongs_to :user

  def self.user_bookmark(user, type, id)
    @bookmark = Bookmark.where(user_id: user.id, bookmarkable_type: type, bookmarkable_id: id).first
    if !@bookmark.blank?
      return false
    else
      return true
    end
  end

  after_save :make_notify
  def make_notify
    @notify = Notify.create(notifyable_id: self.id, notifyable_type: 'Bookmark')
  end

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def who
    if self.user && self.user.profile
      return "#{I18n.t(:bookmark)} #{I18n.t(:via)} <a href='/profiles/#{self.user.profile.id}'>#{self.user.profile.name}</a>"
    else
      return ""
    end
  end

  def who_compact
    if self.user && self.user.profile
      return "#{I18n.t(:bookmark)} #{I18n.t(:via)} #{self.user.profile.name}"
    else
      return ""
    end
  end

  def self.bookmarked(user, uuid)
    @bookmark = Bookmark.where(bookmarkable_id: uuid, user_id: user.id).first
    if !@bookmark.blank?
      return true
    else
      return false
    end
  end

  def self.bookmarks(uuid)
    @bookmark = Bookmark.where(bookmarkable_id: uuid).count
    if !@bookmark.blank?
      return @bookmark
    else
      return 0
    end
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Bookmark.find_by_uuid(uuid)
  end
end
