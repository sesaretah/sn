class Stream < ActiveRecord::Base
  self.primary_key = 'uuid'
  has_many :posts
  has_many :questions
  has_many :uploads, :as => :uploadable, :dependent => :destroy

  def cover(style)
    @upload = Upload.where(uploadable_type: 'Stream', uploadable_id: self.id, attachment_type: 'stream_cover').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-35-#{style}.jpg", :digest => false)
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
    Stream.find_by_uuid(uuid)
  end

end
