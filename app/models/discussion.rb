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
  before_create :set_integer_id
  def set_integer_id
    @last = Discussion.all.order('integer_id desc').first
    if !@last.blank?
      @last_id = @last.integer_id
    else
      @last_id = 0
    end
    self.integer_id = @last_id + 1
  end

  def self.find(uuid)
    Discussion.find_by_uuid(uuid)
  end
end
