class Comment < ActiveRecord::Base

  #attr_accessible :content

  belongs_to :comments

  belongs_to :post
  belongs_to :user
  belongs_to :topic



  #validates body hash.  Must have a minimum of 5 characters, and that a body is present
  validates :body, length: { minimum: 5 }, presence: true
  #validates a user is present within a comment
  validates :user, presence: true

end
