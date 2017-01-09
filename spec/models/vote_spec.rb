require 'rails_helper'
require 'random_data'

RSpec.describe Vote, type: :model do

  # create instances of Vote model spec
  #let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  #let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: 'helloworld') }
  #let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  #let(:vote) { Vote.create!(value: 1, post: post, user: user) }

  # implementing Factory (FactoryGirl)
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:vote) { create(:vote, post: post, user: user) }

  # test that the Vote model belongs to post and User
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

  # validation tests
  # it should have the property of :value
  it { is_expected.to validate_presence_of(:value) }
  # we validate that value is either -1 (down vote) or 1 (up-vote)
  it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1])}


  describe "update_post callback" do
    it "triggers update_post on save" do

      expect(vote).to receive(update_post).at_least(:once)
    end

    it "#update_post should call update_rank on post" do

      expect(post).to receive(:update_rank).at_least(:once)
      vote.save
    end
  end
end
