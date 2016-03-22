require 'rails_helper'
require 'random_data'

# Tests Post migration information within schema
RSpec.describe Post, type: :model do
  # using the let method, we create new instances of the topic, user, and post class
  # we add topic and user because a post is suppose to belong to a topic and a user
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user)  { User.create!(name: 'Bloccit', email: 'user@bloccit.com', password: 'helloworld') }
  #                post should have:   post.title          &               post.body           &          post.user
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }

  # gem 'shoulda'
  # it is expected that posts belong to a topic and a user
  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }

  # it is expected a Post has many comments and labelings
  # it is expected a Post has many labels thorugh labelings
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }

  # it is expected to have the presence of a title, body, and a topic.
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }

  # it is expected to have a title with at least 5 characters and a body with at least 20
  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  describe 'attributes' do
    # test whether post has an attribute named title.
    # this test will return non-nil value when post.title is called
    it 'responds to title' do
      expect(post).to respond_to(:title)
    end
    # same applys as attribute title test above
    it 'responds to body' do
      expect(post).to respond_to(:body)
    end
  end
end
