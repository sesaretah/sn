class Notify < ActiveRecord::Base
  self.primary_key = 'uuid'

  belongs_to :notifyable, :polymorphic => true
  belongs_to :like, :class_name => "Like", :foreign_key => "notifyable_id"

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  after_create :make_notification
  def make_notification
    case self.notifyable_type
    when 'Like'
      @like = Like.find(self.notifyable_id)
      if !@like.blank?
        @item = @like.likeable_type.classify.constantize.find_by_uuid(@like.likeable_id)
        if !@item.blank?
          Notification.create(user_id: @item.owner_id, ownership: 'self', notification_type:'Like' , title: I18n.t(:like), body: @item.raw_content)
          for user_id in Follow.where(followable_type: @item.class.name, followable_id: @item.id).pluck(:user_id)
            Notification.create(user_id: user_id, ownership: 'other', notification_type:'Like' , title: I18n.t(:like), body: @item.raw_content)
          end
        end
      end
    end
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Notify.find_by_uuid(uuid)
  end
end