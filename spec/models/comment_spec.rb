require 'rails_helper'
require 'random_data'

RSpec.describe Comment, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user)  { User.create!(name: 'Bloccit', email: 'user@bloccit.com', password: 'helloworld') }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }

  #:comment is an instance of rspec Comment.  :comment is created with a body,
  # the :post instance of Comment spec (see above) and the :user instance of Comment spec (see above)
  let(:comment) { Comment.create!(body: 'Comment Body', post: post, user: user) }

  # gem 'shoulda' added to rspec.  "it" is applied to the Comment controller in
  # association of belonging to posts and a user
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  # tests that a comments :body is present and it has a minimum length of 5 characters
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe 'attributes' do
    # see post_spec.rb for detailed comments describing similiar attributes
    it 'responds to body' do
      expect(comment).to respond_to(:body)
    end
  end
end
