class Api::V1::TopicsController < Api::V1::BaseController
  # we use before_action to ensure that a user is authenticated and authorized
  # to use the actions in Api::V1:TopicsController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]

  # we write the index action for topics, which is similar to our index action for users
  def index
    topics = Topic.all
    render json: topics.to_json, status: 200
  end
  # show action for Topics
  def show
    topic = Topic.find(params[:id])
    render json: topic.to_json, status: 200
  end
end
