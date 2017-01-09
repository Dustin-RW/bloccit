require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  # a post has a user
  let(:my_user) { create(:user) }
  # a post has a topic
  let(:my_topic) { create(:topic) }
  # testing instance of post
  let(:my_post) { create(:post, topic: my_topic, user: my_user) }

  context 'unauthenticated user' do
    # it shouldn't have an index test here because Post should not
    # have a index action, correct?

    it 'GET show returns http success' do
      get :show, topic_id: my_topic.id, id: my_post.id

      expect(response).to have_http_status(:success)
    end
  end

  context 'unauthorized user' do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    # no index TDD here too, right?

    it 'GET show returns http success' do
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end
  end
end
