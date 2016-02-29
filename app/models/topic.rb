class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :sponsoredposts
end
