class Role < ActiveRecord::Base
  self.primary_key = 'uuid'
    has_one :access_control

  has_many :users, :through => :assignments
  has_many :assignments, dependent: :destroy

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Role.find_by_uuid(uuid)
  end
end
