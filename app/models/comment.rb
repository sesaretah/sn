class Comment < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :discussion
  has_many :uploads, :as => :uploadable, :dependent => :destroy

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Comment.find_by_uuid(uuid)
  end
end
