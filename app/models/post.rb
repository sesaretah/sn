class Post < ActiveRecord::Base
  belongs_to :stream
  has_many :discussions
end
