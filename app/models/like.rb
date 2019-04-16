class Like < ActiveRecord::Base
  self.primary_key = 'uuid'

  belongs_to :likeable, :polymorphic => true
  belongs_to :stream, :class_name => "Like", :foreign_key => "likeable_id"

  belongs_to :user


  def self.user_like(user, type, id)
    @like = Like.where(user_id: user.id, likeable_type: type, likeable_id: id).first
    if !@like.blank?
      return false
    else
      return true
    end
  end

  after_save :make_notify
  def make_notify
    @notify = Notify.create(notifyable_id: self.id, notifyable_type: 'Like')
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
      return "#{I18n.t(:like)} #{I18n.t(:via)} <a href='/profiles/#{self.user.profile.id}'>#{self.user.profile.name}</a>"
    else
      return ""
    end
  end

  def self.find(uuid)
    Like.find_by_uuid(uuid)
  end
end
