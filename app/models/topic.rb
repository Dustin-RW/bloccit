class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  #define a has many relationship between Topic and Labeling
  has_many :labelings, as: :labelable
  #define a has many relationship between Topic and a label using the Label class through the
  #labelable interface
  has_many :labels, through: :labelings

  # We use lambda syntax (the arrow -> with a block), which is the
  # proper way to pass code into a scope definition. This scope runs the
  # code inside the lambda on the relation or class on which it's called.
  # In other words, Topic.visible_to is equivalent to Topic.where(public: true)
  # scope :visible_to, -> { where(public: true) }

  # instead of above, where we would have to implement a if statement
  # within TopicController, we instead pass the scope an argument to
  # determine if a user is signed in or not
  scope :visible_to, -> (user) { user ? all : where(public: true) }


end
