class User < ActiveRecord::Base
  # User model to represent the users of Bloccit with the following attributes:
  # name, email, password_digest

  # A User has many posts
  has_many :posts
  # A User has many comments
  has_many :comments

  # before saving of a User, transform the provided email (self) into all downcase letters
  before_save { self.email = email.downcase }
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

  enum role: [:member, :admin, :moderator]
end
