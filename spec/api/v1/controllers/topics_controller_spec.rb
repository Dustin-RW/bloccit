require 'rails_helper'

RSpec.describe Api::V1::TopicsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_topic) { create(:topic) }

  # we want unauthenticated users to be able to fetch a topic or all topics, per our access rules
  context 'unauthenticated user' do
    it 'GET index returns https' do
      get :index

      expect(response).to have_http_status(:success)
    end

    it 'GET show returns http success' do
      get :show, id: my_topic.id

      expect(response).to have_http_status(:success)
    end
  end

  # we want unauthorized users to be able to fetch a topic or all topics, per our access rules
  context 'unauthorized user' do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it 'GET index returns http success' do
      get :index

      expect(response).to have_http_status(:success)
    end

    it 'GET show returns http success' do
      get :show, id: my_topic.id

      expect(response).to have_http_status(:success)
    end
  end
end
