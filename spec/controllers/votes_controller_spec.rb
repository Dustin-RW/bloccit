require 'rails_helper'
require 'random_data'
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  let(:my_user) { User.create!(name: 'Bloccit User', email: 'user@bloccit.com', password: 'helloworld') }
  let(:other_user) { User.create!(name: RandomData.random_name, email: RandomData.random_email, password: 'helloworld', role: :member) }
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: other_user) }
  let(:my_vote) { Vote.create!(value: 1) }

  # we test that an unsigned-in users are redirected
  # to the sign-in page
  context 'guest' do
    describe 'POST up_vote' do
      it 'redirects the user to the sign in view' do
        post :up_vote, post_id: user_post.id

        expect(response).to redirect_to(new_session_path)
      end
    end

    describe 'Post down_vote' do
      it 'redirects the user to the sign in view' do
        delete :down_vote, post_id: user_post.id

        expect(response).to redirect_to(new_session_path)
      end
    end
  end
  # we create a context to test signed-in users, who should
  # be allowed to vote
  context 'signed in user' do
    before do
      create_session(my_user)
      request.env['HTTP_REFERER'] = topic_post_path(my_topic, user_post)
    end

    describe 'Post up_vote' do
      # we expect that the first time a user up votes a post,
      # a new vote is created for the post
      it 'the users first vote increases number of post votes by one' do
        # create votes variable of type integer
        votes = user_post.votes.count
        # render the post action up_vote.  Post (that is being "displayed")
        # belongs to user_post.id
        post :up_vote, post_id: user_post.id
        # expect the user_post.votes.count to be one more after POST
        expect(user_post.votes.count).to eq(votes + 1)
      end
      # we test to make sure a user cannot increase the votes
      # if he or she already voted on the post
      it 'the users second vote does not increase the number of votes' do
        post :up_vote, post_id: user_post.id
        votes = user_post.votes.count
        # render post action again and make sure votes did not increase
        post :up_vote, post_id: user_post.id

        expect(user_post.votes.count).to eq(votes)
      end

      it 'increases the sum of post votes by one' do
        # set points variable up
        points = user_post.points
        # call post action up_vote with user_post.id as template
        post :up_vote, post_id: user_post.id
        # expect the template of user_post.points to increase by 1
        expect(user_post.points).to eq(points + 1)
      end

      it ':back redirects to posts show page' do
        # redirected back dependent on which show.html they were on
        request.env['HTTP_REFERER'] = topic_post_path(my_topic, user_post)
        post :up_vote, post_id: user_post.id

        expect(response).to redirect_to([my_topic, user_post])
      end

      it ':back redirects to posts topic show' do
        request.env['HTTP_REFERER'] = topic_path(my_topic)
        post :up_vote, post_id: user_post.id

        expect(response).to redirect_to(my_topic)
      end
    end

    describe 'POST down_vote' do
      it 'the users first vote increases number of post votes by 1' do
        votes = user_post.votes.count
        post :down_vote, post_id: user_post.id

        expect(user_post.votes.count).to eq(votes + 1)
      end

      it 'the users second vote does not increase the number of votes' do
        post :down_vote, post_id: user_post.id
        votes = user_post.votes.count
        post :down_vote, post_id: user_post.id

        expect(user_post.votes.count).to eq(votes)
      end

      it 'descreases the sum of post votes by one' do
        points = user_post.points
        post :down_vote, post_id: user_post.id

        expect(user_post.points).to eq(points - 1)
      end

      it ':back redirects to posts show page' do
        request.env['HTTP_REFERER'] = topic_post_path(my_topic, user_post)
        post :down_vote, post_id: user_post.id
        expect(response).to redirect_to([my_topic, user_post])
      end

      it ':back redirects to posts topic show' do
        request.env['HTTP_REFERER'] = topic_path(my_topic)
        post :down_vote, post_id: user_post.id
        expect(response).to redirect_to(my_topic)
      end
    end
  end
end
