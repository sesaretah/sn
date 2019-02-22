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

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Share.find_by_uuid(uuid)
  end
end
