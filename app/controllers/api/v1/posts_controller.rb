class Api::V1::PostsController < Api::V1::BaseController
  # we use before_action to ensure that a user is authenticated and authorized
  # to use the actions in Api::V1:TopicsController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]

  def update
    post = Post.find(params[:id])

    if post.update_attributes(post_params)
      render json: post.to_json, status: 200
    else
      render json: {error: "Post update failed", status: 400}, status: 400
    end

  end

  def create
    topic = Topic.find(params[:topic_id])
    post = topic.post.build(post_params)

    post.user = current_user

    if post.valid?
      post.save!
      render json: topic.to_json, status: 201
    else
      render json: {error: "Post is invalid", status: 400}, status: 400
    end

  end

  def destroy
    post = Post.find(params[:id])

    if post.destroy
      render json: {meesage: "Post destroyed", status: 200}, status: 200
    else
      render json: {error: "Post destroy failed", status: 400}, status: 400
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
