require 'rails_helper'
require 'random_data'

RSpec.describe Topic, type: :model do
  # let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}

  # implementing FavoriteGirl
  let(:topic) { create(:topic) }

  # Shoulda expects Topic to have many posts and labelings
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:labelings) }
  # Shoulda expects Topic to have many labels through labelings
  it { is_expected.to have_many(:labels).through(:labelings) }

  describe 'attributes' do
    it 'responds to name' do
      expect(topic).to respond_to(:name)
    end

    it 'responds to description' do
      expect(topic).to respond_to(:description)
    end

    it 'responds to public' do
      expect(topic).to respond_to(:public)
    end

    it 'is public by default' do
      expect(topic.public).to be(true)
    end
  end

  describe "scopes" do
    # we create public and private topics to use for testing scopes
    before do
      @public_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @private_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: false)
    end

    describe "visible_to(user)" do
      # we expect the visible_to scope to return all topics if the user is present.
      it "returns all the topics if the user is present" do
        user = User.new

        expect(Topic.visible_to(user)).to eq(Topic.all)
      end
      # we expect the visible_to scope to return public topics if the user isn't present
      it "returns only public topics if user is nil" do

        expect(Topic.visible_to(nil)).to eq([@public_topic])
      end
    end

    describe "publicly_viewable" do
      it "returns all the public topics" do
        expect(Topic.publicly_viewable).to eq([@public_topic])
      end
    end

    describe "privately_viewable" do
      it "returns all the private topics" do
        expect(Topic.privately_viewable).to eq([@private_topic])
      end
    end
  end
end
