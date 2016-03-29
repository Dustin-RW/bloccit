require 'random_data'

FactoryGirl.define do
  factory :post do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    # why is topic and user here?
    # what the hell is rank 0.0, lol?
    topic # probably equivalent to topic.post.create?
    user # equivalent to user: user?
    rank 0.0
  end
end
