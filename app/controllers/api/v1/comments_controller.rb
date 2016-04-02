class Api::V1::CommentsController < Api::V1::BaseController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]

  def index
    comments = Comments.all
    render json: comments.to_json, status: 200
  end

  def show
    # I take it Post.find is necassary here?  Why do we not have to incorporate instance variables?
    post = Post.find(params(:post_id))
    comment = Comment.find(params[:id])
    render json: topic.to_json, status: 200
  end
end
