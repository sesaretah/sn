class Assignment < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :user
  belongs_to :role

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Assignment.find_by_uuid(uuid)
  end
end
