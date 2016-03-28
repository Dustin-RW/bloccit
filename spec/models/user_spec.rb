require 'rails_helper'
require 'random_data'

RSpec.describe User, type: :model do
  # creates an instance of User
  let(:user) { User.create!(name: 'Bloccit User', email: 'user@bloccit.com', password: 'password') }

  # A user has posts
  it { is_expected.to have_many(:posts) }

  # A user has posts that has comments
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favorites) }

  # Shoulda tests for name presence and name length
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  # Shoulda tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value('user@bloccit').for(:email) }

  # Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  #=========================================================================
  describe 'attributes' do
    it 'should respond to name' do
      expect(user).to respond_to(:name)
    end

    it 'should respond to email' do
      expect(user).to respond_to(:email)
    end

    it 'responds to role' do
      expect(user).to respond_to(:role)
    end

    it 'responds to admin?' do
      expect(user).to respond_to(:admin?)
    end

    it 'responds to member?' do
      expect(user).to respond_to(:member?)
    end

    it 'responds to moderator' do
      expect(user).to respond_to(:moderator?)
    end
  end
  #=========================================================================
  # we want a User to respond to roles.  Roles will be created via an enum within
  # the User Model
  describe 'roles' do
    # we expect a User to have a role as a member by default
    it 'is member by default' do
      expect(user.role).to eql('member')
    end

    context 'member user' do
      # if a member is signed in, we expect they are truthy, instead of falsey
      it 'returns true for #member' do
        expect(user.member?).to be_truthy
      end

      it 'returns false for #admin' do
        expect(user.admin?).to be_falsey
      end
    end

    context 'admin user' do
      # to meet the testing specs for an admin, we need to assign the instance
      # user, within the test spec, to be an admin
      before do
        user.admin!
      end
      # we test truthy and falsey for admin
      it 'returns false for #member' do
        expect(user.member?).to be_falsey
      end

      it 'returns true for #admin' do
        expect(user.admin?).to be_truthy
      end
    end
  end

  # tests that conduct the simulation of an invalid name
  describe 'invalid user' do
    # within describe, creation of an invalid name and email
    let(:user_with_invalid_name) { User.new(name: '', email: 'user@bloccit.com') }
    let(:user_with_invalid_email) { User.new(name: 'Bloccit User', email: '') }

    it 'should be an invalid user due to a blank name' do
      expect(user_with_invalid_name).to_not be_valid
    end

    it 'should be an invalid user due to a blank email' do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  # test the favorite_for(post) method
  describe '#favorite_for(post)' do
    before do
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
    end

    it "returns 'nil' if the user has not favorited the post" do
      expect(user.favorite_for(@post)).to be_nil
    end

    it 'returns the appropriate favorite if it exists' do
      # we create a favorite for user and @post
      favorite = user.favorites.where(post: @post).create

      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end
end
