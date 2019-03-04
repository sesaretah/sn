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

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Bookmark.find_by_uuid(uuid)
  end
end
