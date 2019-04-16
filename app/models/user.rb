class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_format_of :mobile, :with => /[0][9][1][0-9]{8,8}/i, :on => :create
  validates :username, uniqueness: true

  has_one :profile, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :streams, dependent: :destroy
  has_many :notification_settings, dependent: :destroy
  has_many :privacy_policies, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :roles, :through => :assignments
  has_many :assignments, dependent: :destroy
  has_many :interconnects, dependent: :destroy

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
