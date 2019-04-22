class Follow < ActiveRecord::Base
  self.primary_key = 'uuid'

  belongs_to :followable, :polymorphic => true
  belongs_to :stream, :class_name => "Stream", :foreign_key => "followable_id"
  belongs_to :post, :class_name => "Post", :foreign_key => "followable_id"
  belongs_to :profile, :class_name => "Profile", :foreign_key => "followable_id"

  belongs_to :user

  def self.user_follow(user, type, id)
    @follow = Follow.where(user_id: user.id, followable_type: type, followable_id: id).first
    if !@follow.blank?
      return false
    else
      return true
    end
  end


  after_save :make_notify
  def make_notify
    @notify = Notify.create(notifyable_id: self.id, notifyable_type: 'Follow')
  end

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def who
    if self.user && self.user.profile
      return "#{I18n.t(:follow)} #{I18n.t(:via)} <a href='/profiles/#{self.user.profile.id}'>#{self.user.profile.name}</a>"
    else
      return ""
    end
  end


  def who_compact
    if self.user && self.user.profile
      return "#{I18n.t(:follow)} #{I18n.t(:via)} #{self.user.profile.name}"
    else
      return ""
    end
  end

  def self.followed(user, uuid)
    @follow = Follow.where(followable_id: uuid, user_id: user.id).first
    if !@follow.blank?
      return true
    else
      return false
    end
  end

  def self.follows(uuid)
    @follow = Follow.where(followable_id: uuid).count
    if !@follow.blank?
      return @follow
    else
      return 0
    end
  end

  def self.find(uuid)
    Follow.find_by_uuid(uuid)
  end
end
