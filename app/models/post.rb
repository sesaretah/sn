class Post < ActiveRecord::Base
  self.primary_key = 'uuid'
  has_many :discussions
  belongs_to :stream
  has_many :uploads, :as => :uploadable, :dependent => :destroy
  has_many :shares, :as => :shareable, :dependent => :destroy
  belongs_to :user

  def cover(style)
    @upload = Upload.where(uploadable_type: 'Post', uploadable_id: self.id, attachment_type: 'post_attachment').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-35-#{style}.jpg", :digest => false)
    end
  end

  def image(style)
    @upload = Upload.where(uploadable_type: 'Post', uploadable_id: self.id, attachment_type: 'post_attachment').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-#{style}.png", :digest => false)
    end
  end

  after_create :set_share

  def set_share
    Share.create(shareable_id: self.id, shareable_type: 'Post', stream_id: self.stream_id, user_id: self.user_id)
  end


  def name
    self.title
  end

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Post.find_by_uuid(uuid)
  end
end
