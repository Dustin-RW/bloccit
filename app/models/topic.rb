class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  #define a has many relationship between Topic and Labeling
  has_many :labelings, as: :labelable
  #define a has many relationship between Topic and a label using the Label class through the
  #labelable interface
  has_many :labels, through: :labelings

  has_many :comments, dependent: :destroy


end
