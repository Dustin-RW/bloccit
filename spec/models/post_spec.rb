require 'rails_helper'
require 'random_data'

# Tests Post migration information within schema
RSpec.describe Post, type: :model do
  # using the let method, we create new instances of the topic, user, and post class
  # we add topic and user because a post is suppose to belong to a topic and a user
  # let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  # let(:user)  { User.create!(name: 'Bloccit', email: 'user@bloccit.com', password: 'helloworld') }
  #                post should have:   post.title          &               post.body           &          post.user
  # let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }

  # implementing FavoriteGirl
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  # gem 'shoulda'
  # it is expected that posts belong to a topic and a user
  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }

  # it is expected a Post has many comments and labelings
  # it is expected a Post has many labels thorugh labelings
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favorites) }
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

  describe 'voting' do
    # create three up votes and 2 down votes before each voting spec
    before do
      3.times { post.votes.create!(value: 1) }
      2.times { post.votes.create!(value: -1) }
      @up_votes = post.votes.where(value: 1).count
      @down_votes = post.votes.where(value: -1).count
    end

    # test that up_votes returns the count of up votes
    describe '#up_votes' do
      it 'counts the number of votes with the value = 1' do
        expect(post.up_votes).to eq(@up_votes)
      end
    end

    # test that down_votes returns the count of down votes
    describe '#down_votes' do
      it 'counts the number of votes with the value = -1' do
        expect(post.down_votes).to eq(@down_votes)
      end
    end

    describe '#points' do
      it 'returns the sum of all down and up votes' do
        expect(post.points).to eq(@up_votes - @down_votes)
      end
    end

    describe '#update_rank' do
      it 'calculates the correct rank' do
        post.update_rank
        # Determine the age of the post by subtracting a standard time from its
        # created_at time. A standard time in this context is known as an epoch.
        # This makes newer posts start with a higher ranking, which decays over time
        expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970, 1, 1)) / 1.day.seconds)
      end

      it 'updates the rank when an up vote is created' do
        old_rank = post.rank
        post.votes.create!(value: 1)
        expect(post.rank).to eq (old_rank + 1)
      end

      it 'updates the rank when a down vote is created' do
        old_rank = post.rank
        post.votes.create!(value: -1)
        expect(post.rank).to eq (old_rank - 1)
      end
    end
=begin
    describe "#create_vote" do
      it "triggers create_vote after save post" do
        expect(post).to receive(create_vote)
        post.save
      end

      it "post should have 1 up vote after creation" do
        post.up_votes = 0
        post.create_vote

        expect(post.up_votes).to eq(1)
      end


    end
=end
  end
end
