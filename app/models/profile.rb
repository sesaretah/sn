class Profile < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :user
  has_many :uploads, :as => :uploadable, :dependent => :destroy

  def image(style)
    @upload = Upload.where(uploadable_type: 'Profile', uploadable_id: self.id, attachment_type: 'profile_avatar').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-#{style}.png", :digest => false)
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
    Profile.find_by_uuid(uuid)
  end
end
