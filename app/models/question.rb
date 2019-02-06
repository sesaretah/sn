class Question < ActiveRecord::Base
  self.primary_key = 'uuid'

  belongs_to :stream
  has_many :answers
  has_many :uploads, :as => :uploadable, :dependent => :destroy
  belongs_to :user

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Question.find_by_uuid(uuid)
  end
end
