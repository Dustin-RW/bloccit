class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  after_create :send_favorite_emails

  # validates body hash.  Must have a minimum of 5 characters, and that a body is present
  validates :body, length: { minimum: 5 }, presence: true
  # validates a user is present within a comment
  validates :user, presence: true

  private

  def send_favorite_emails
    post.favorites.each do |favorite|
      FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
    end
  end
end
