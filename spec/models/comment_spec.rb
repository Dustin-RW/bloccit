require 'rails_helper'
require 'random_data'

RSpec.describe Comment, type: :model do
  # instance variables within spec because a comment belongs to a post, which belongs
  # to a topic and a user
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user)  { User.create!(name: 'Bloccit', email: 'user@bloccit.com', password: 'helloworld') }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }

  # :comment is an instance of rspec Comment.  :comment is created with a body,
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

  describe 'after_create' do
    # we initialize (but don't save) a new comment for post
    before do
      @another_comment = Comment.new(body: 'Comment Body', post: post, user: user)
    end

    # we favorite post then expect FavoriteMailer will receive a call to
    # new_comment. We then save @another_comment to trigger the after create callback
    it 'sends an email to users who have favorited the post' do
      favorite = user.favorites.create(post: post)
      expect(FavoriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))

      @another_comment.save!
    end

    # test that FavoriteMailer does not receive a call to new_comment when
    # post isn't favorited
    it "does not send emails to users who haven't favorited the post" do
      expect(FavoriteMailer).not_to receive(:new_comment)

      @another_comment.save!
    end
  end
end
