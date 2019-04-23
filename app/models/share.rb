class Share < ActiveRecord::Base
  self.primary_key = 'uuid'

  belongs_to :shareable, :polymorphic => true
  belongs_to :stream, :class_name => "Stream", :foreign_key => "shareable_id"
  belongs_to :post, :class_name => "Post", :foreign_key => "shareable_id"
  belongs_to :user

  def self.user_share(user, type, id)
    @share = Share.where(user_id: user.id, shareable_type: type, shareable_id: id).first
    if !@share.blank?
      return false
    else
      return true
    end
  end

  after_save :make_notify
  def make_notify
    @notify = Notify.create(notifyable_id: self.id, notifyable_type: 'Share')
  end

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def who
    if self.user && self.user.profile
      return "#{I18n.t(:share)} #{I18n.t(:via)} <a href='/profiles/#{self.user.profile.id}'>#{self.user.profile.name}</a>"
    else
      return ""
    end
  end

  def who_compact
    if self.user && self.user.profile
      return "#{I18n.t(:share)} #{I18n.t(:via)} #{self.user.profile.name}"
    else
      return ""
    end
  end

  def self.shared(user, uuid)
    @share = Share.where(shareable_id: uuid, user_id: user.id).first
    if !@share.blank?
      return true
    else
      return false
    end
  end

  def self.shares(uuid)
    @share = Share.where(shareable_id: uuid).count
    if !@share.blank?
      return @share
    else
      return 0
    end
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Share.find_by_uuid(uuid)
  end
end
