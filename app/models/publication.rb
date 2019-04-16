class Publication < ActiveRecord::Base
  self.primary_key = 'uuid'

  def image(style)
    @upload = Upload.where(uploadable_type: 'Publication', uploadable_id: self.id, attachment_type: 'publication_attachment').first
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

  def name
    self.title
  end

  def raw_content
    self.content
  end

  def owner_id
    if !self.user_id.blank?
      return self.user_id
    end
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Publication.find_by_uuid(uuid)
  end
end
