require 'rails_helper'
require 'random_data'

RSpec.describe SponsoredPost, type: :model do

  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:sponsoredpost) { topic.sponsoredposts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number)}

  it { is_expected.to belong_to(:topic) }

  describe "attributes" do
    it "responds to title" do
      expect(sponsoredpost).to respond_to(:title)
    end

    it "responds to body" do
      expect(sponsoredpost).to respond_to(:body)
    end

    it "responds to price" do
      expect(sponsoredpost).to respond_to(:price)
    end
  end
end
