class CommentsController < ApplicationController
  # found in ApplicationController.  Unless user is signed in, they cannot
  # perform any actions within the CommentsController and will receive an error
  before_action :require_sign_in
  # unauthorized users are not allowed to delete comments
  before_action :authorize_user, only: [:destroy]

  def create

    id = params[:post_id] || params[:topic_id]
    if params[:post_id]
      @parent = Post.find(id)
    elsif params[:topic_id]
      @parent = Topic.find(id)
    end
    @comment = @parent.comments.build(comment_params)
    p "Here is the comment", @comment
    p "Here is the passed id", @parent.attributes
    @comment = @parent.comments.find(params[:id])
    p "Here is the new comment", @comment

    @comment.save


=begin
    if @parent == params[:post_id]
      comment.save
      flash[:notice] = 'Comment saved successfully'
      redirect_to [@post.topic, @post]
    elsif @parent.topic == params[:topic_id]
      comment.save
      flash[:notice] = 'Comment saved successfully'
      redirect_to @topic
    else
      flash[:alert] = 'Comment failed to save'
      redirect_to :back
    end
=end
  end

  def destroy
    comment = Comment.find(params[:id])
    # @topic = Topic.find(params[:topic_id])
    # topic_comment = @topic.comments.find(params[:id])

    # @post = Post.find(params[:post_id])
    # post_comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = 'Comment was deleted'
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
      flash[:alert] = 'You do not have permission to delete a comment.'
      redirect_to [comment.post.topic, comment.post]
    end
  end
end
