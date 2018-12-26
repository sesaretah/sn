class Discussion < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :comments
end
