
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
  # this relates the models and allows us to call post.votes
  has_many :votes, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  # assignment-43, implement an after_create method called create_vote
  after_create :create_vote

  # default_scope {order('created_at DESC')}
  default_scope { order('rank DESC') }

  # validate that the title, has a length of at least 5 characters and that it is present
  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  # validates that post has a topic and a user
  validates :topic, presence: true
  validates :user, presence: true

  # we find the up votes for a post by passing the value: 1 to where
  # this fetches a collection of votes with a value of 1.
  # we then call count on the collection to get a total of all up votes
  def up_votes
    votes.where(value: 1).count
  end
  # same idea as up_votes, but returning a count of down_votes
  def down_votes
    votes.where(value: -1).count
  end
  # using ActiveRecords sum method to add the value of all the
  # given post's votes.  Passing :value to sum tells it what
  # attribute to sum in the collection
  def points
    votes.sum(:value)
  end

  # **Note: votes in the above code is an implied self.votes

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  private
  # assignment-43, name method create_vote and make it private
  def create_vote
    # use user.votes.create and set the post association equal
    # to self and the value to equal 1
    user.votes.create( value: 1, post: self)
  end
end
