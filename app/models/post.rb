
# when rails generate model namehere created this class, it made the class inherhit
# from ActiveRecord::Base.  ActiveRecord::Base essentially handles interaction with
# the database and allows us to persist data through our class
class Post < ActiveRecord::Base

  belongs_to :topic
  belongs_to :user

  # The has_many method allows a post instance to have many comments related to it,
  # and also provides methods that allow us to retrieve comments that belong to
  # a post
  has_many :comments, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  default_scope {order('created_at DESC')}

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

end
