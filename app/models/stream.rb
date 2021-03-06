class Stream < ActiveRecord::Base
  self.primary_key = 'uuid'
  has_many :posts
  has_many :questions
  has_many :uploads, :as => :uploadable, :dependent => :destroy
  has_many :follows, :as => :followable, :dependent => :destroy
  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :shares, :as => :shareable, :dependent => :destroy
  has_many :bookmarks, :as => :bookmarkable, :dependent => :destroy
  belongs_to :user

  def cover(style)
    @upload = Upload.where(uploadable_type: 'Stream', uploadable_id: self.id, attachment_type: 'stream_cover').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-35-#{style}.jpg", :digest => false)
    end
  end

  def image(style)
    @upload = Upload.where(uploadable_type: 'Stream', uploadable_id: self.id, attachment_type: 'stream_cover').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-#{style}.png", :digest => false)
    end
  end

  def owner_id
    if !self.user_id.blank?
      return self.user_id
    end
  end

  before_create :set_integer_id
  def set_integer_id
    @last = Stream.all.order('integer_id desc').first
    if !@last.blank?
      @last_id = @last.integer_id
    else
      @last_id = 0
    end
    self.integer_id = @last_id + 1
  end



  def name
    self.title
  end

  def raw_content
    self.details
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
