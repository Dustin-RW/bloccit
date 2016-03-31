class CommentsController < ApplicationController
  # found in ApplicationController.  Unless user is signed in, they cannot
  # perform any actions within the CommentsController and will receive an error
  before_action :require_sign_in
  # unauthorized users are not allowed to delete comments
  before_action :authorize_user, only: [:destroy]

  def create

    # upon clicking on create, determine what param id is passed
    if params[:post_id]
      # if it is a post id, set instance of post id as @parent
      @parent = Post.find(params[:post_id])
    elsif params[:topic_id]
      # if it is a topic id, set instance of topic id as @parent
      @parent = Topic.find(params[:topic_id])
    end

    # create instance as @comment.  Build/create
    # comment belonging to @parent (Topic or Post)
    @comment = @parent.comments.build(comment_params)
    # The comment must be associated to the current user.
    # A comment must have a user, and value of user within instance of @comment
    # is currently nil.  Set user id as current user
    @comment.user = current_user

    # save comment to database
    if @comment.save
      # direction of save through if and elsif
      # Redirection depends on the comment's parent.
      # .is_a? method determines if it is of a certain class.  Here, is @parent
      # of class Post?  Is @parents is the same parent id passed through params?
      if @parent.is_a?(Post) # template error with this included: (== params[:post_id])
        flash[:notice] = 'Comment saved successfully'
        redirect_to [@parent.topic, @parent]
      # if not part of the class Post, is it a Topic?  If so, save here and
      # redirect to the topic after save
      elsif @parent.is_a?(Topic)
        flash[:notice] = 'Comment saved successfully'
        redirect_to @parent
       end
    end
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
