class Like < ActiveRecord::Base
  self.primary_key = 'uuid'

  belongs_to :followable, :polymorphic => true
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

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Like.find_by_uuid(uuid)
  end
end
