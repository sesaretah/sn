class Discussion < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :post
  belongs_to :user
  has_many :comments

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Discussion.find_by_uuid(uuid)
  end
end
