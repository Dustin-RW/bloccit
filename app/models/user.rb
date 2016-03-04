class User < ActiveRecord::Base

  before_save :downcase_email
  before_save :capitalize_first_last

  validates :name, length: {minimum: 1, maximum: 100}, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  has_secure_password


  private
  def capitalize_first_last
    self.name = name.split.map!{ |cap| cap.capitalize }.join(" ")
  end

  def downcase_email
    self.email = email.downcase
  end


end
