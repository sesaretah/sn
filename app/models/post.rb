class Post < ActiveRecord::Base
  self.primary_key = 'uuid'
  has_many :discussions, :dependent => :destroy
  belongs_to :stream
  has_many :uploads, :as => :uploadable, :dependent => :destroy
  has_many :shares, :as => :shareable, :dependent => :destroy
  has_many :follows, :as => :followable, :dependent => :destroy
  belongs_to :user

  def cover(style)
    @upload = Upload.where(uploadable_type: 'Post', uploadable_id: self.id, attachment_type: 'post_attachment').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-35-#{style}.jpg", :digest => false)
    end
  end

  before_create :set_integer_id
  def set_integer_id
    @last = Post.all.order('integer_id desc').first
    if !@last.blank?
      @last_id = @last.integer_id
    else
      @last_id = 0
    end
    self.integer_id = @last_id + 1
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

  def owner_id
    if !self.user_id.blank?
      return self.user_id
    else
      return self.stream.user_id
    end
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
