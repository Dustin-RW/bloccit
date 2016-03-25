class CommentsController < ApplicationController

  #found in ApplicationController.  Unless user is signed in, they cannot
  #perform any actions within the CommentsController and will receive an error
  before_action :require_sign_in
  #unauthorized users are not allowed to delete comments
  before_action :authorize_user, only: [:destroy]

  def create
    @topic = Topic.find(params[:topic_id])
    topic_comment = @topic.comment.new(comment_params)
    #find the correct post using the :post_id from params
    @post = Post.find(params[:post_id])
    #create a new comment using comment_params
    post_comment = @post.comments.new(comment_params)
    #assign the comments user to current_user which returns the signedin user instance
    comment.user = current_user

    if post_comment.save
      flash[:notice] = "Comment saved successfully"
      redirect_to [@post.topic, @post]
    elsif topic_comment.save
      flash[:notice] = "Comment saved successfully"
      redirect_to @topic
    else
      flash[:alert] = "Comment failed to save"
      redirect_to [@post.topic, @post]
    end

  end

  def destroy

    comment = Comment.find(params[:id])
    #@topic = Topic.find(params[:topic_id])
    #topic_comment = @topic.comments.find(params[:id])

    #@post = Post.find(params[:post_id])
    #post_comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted"
      redirect_to :back
    else
      flash[:alert] = "Comment counld't be deleted. Try again"
      redirect_to :back
    end

  end

  private


  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])

    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end

end
