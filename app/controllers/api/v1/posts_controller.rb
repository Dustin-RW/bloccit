class Api::V1::PostsController < Api::V1::BaseController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]

  def index
    # is this just for the assignment?  I thought an index of Posts was not necassary regarding bloccit application?
    posts = Posts.all
    render json: topics.to_json, status: 200
  end

  def show
    topic = Topic.find(params[:topic_id])
    post = Post.find(params[:id])
    render json: topic.to_json, status: 200
  end
end
