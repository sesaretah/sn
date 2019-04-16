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

  def self.find(uuid)
    Follow.find_by_uuid(uuid)
  end
end
