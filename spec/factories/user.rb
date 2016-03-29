# addresses the create(:user) method by creating a user factory
# see spec/controllers/user_controller_spec.rb
require 'random_data'

FactoryGirl.define do
  pw = RandomData.random_sentence
  # declare the name of the factory :user
  factory :user do
    name RandomData.random_name
    # each User that the factory builds will have a unique email address
    # using sequence.
    sequence(:email){ |n| "users#{n}@factory.com"}
    password pw
    password_confirmation pw
    role :member
  end
end
