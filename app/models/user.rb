class User < ActiveRecord::Base
  # User model to represent the users of Bloccit with the following attributes:
  # name, email, password_digest

  # A User has many posts
  has_many :posts, dependent: :destroy
  # A User has many comments
  has_many :comments, dependent: :destroy
  # A User has many votes
  has_many :votes, dependent: :destroy
  # A User has many favorites
  has_many :favorites, dependent: :destroy

  # before saving of a User, transform the provided email (self) into all downcase letters
  before_save { self.email = email.downcase }

  # have to add this to use enum role down below
  # shorthand for { self.role = :member if self.role.nil? }
  # basically stating if self.role is nil (empty), assign it as a member by default
  before_save { self.role ||= :member }

  # validates that user has a name (hence presence) with a min-max of 1-100 characters
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  # The first validation executes if password_digest is nil. This ensures that
  # when we create a new user, they have a valid password
  validates :password, presence: true, length: { minimum: 6 }, if: 'password_digest.nil?'
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  # "adds methods to set and authenticate against a BCrypt password.
  # This mechanism requires you to have a password_digest attribute."
  # (http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password)
  has_secure_password

  # special attribute type whose values map to integers, but can be referenced by name
  # creates a column in the User database name role, and allows us to assign
  # and referencec roles using admin or member
  # see (http://edgeapi.rubyonrails.org/classes/ActiveRecord/Enum.html)
  enum role: [:member, :admin, :moderator]

  # This method takes a post object and uses where to retrieve the user's favorites
  # with a post_id that matches post.id. If the user has favorited post it will
  # return an array of one item. If they haven't favorited post it will return
  # an empty array. Calling first on the array will return either the favorite
  # or nil depending on whether they favorited the post
  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end


  # no idea what this method did other then deliver a sized picture
  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
