class PostsController < ApplicationController
  # private methods found at bottom

  # require_sign_in method found in application_controller.rb.  Method runs before any action
  # within post controller except within and show
  # before_action see(http://guides.rubyonrails.org/action_controller_overview.html)
  # require_sign_in requires a current_user except for show
  before_action :require_sign_in, except: :show

  # check the role via enum (found in User model) before rendering any actions
  # other then the show, new, and create action
  before_action :authorize_user, except: [:show, :new, :create]

  #  def index
  #  end
  #========================================
  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
  end

  #========================================
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    @post.topic = @topic
  end

  #========================================
  def create
    @topic = Topic.find(params[:topic_id])

    @post = @topic.posts.build(post_params)
    # => below is code smell and above refactors it all into one line
    #       @post = @post.new
    #       @post.title = params[:post][:title]
    #       @post.body = params[:post][:body]
    #       @topic = Topic.find(params[:topic_id])
    #       @post.topic = @topic

    # we assign @post.user in the same way we assigned @post.topic,
    # to properly scope the new post.
    @post.user = current_user

    if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
      flash[:notice] = 'Post was saved'
      redirect_to [@topic, @post]
    else

      flash.now[:alert] = 'There was an error saving the post.  Please try again'
      render :new
    end
  end

  #========================================
  def edit
    @post = Post.find(params[:id])
  end
  #========================================

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)
    # => below is another code smell and is refactored above
    #      @post.title = params[:post][:title]
    #      @post.body = params[:post][:body]


    if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
      flash[:notice] = 'Post was updated.'
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = 'There was an error saving the post. Please try again'
      render :edit
    end
  end

  #========================================

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully"
      redirect_to @post.topic
    else
      flash.now[:alert] = 'There was an error deleting the post.'
      render :show
    end
  end

  private

  def post_params
    # to use mass assignment w/ parameters:
    # have to use .require which ensures a parameter is always present (example below:  :post )
    # then we can use .permit to declare which paremeters (here of :post) to allow
    params.require(:post).permit(:title, :body)
  end

  # Here post runs within the 'before_action' regarding actions within
  # Post controller (see above).  If post params via URL are not passed/equal to the current_user
  # or admin within the specific post, user will be redirected to the post they just tried to edit.
  # Otherwise, the user and/or the admin has the rights to edit/delete said post
  def authorize_user
    # stores action past, gathered by params, and stores action into action variable
    action = params['action']

    # passes current post and all of its keys and values, via params, inside variable post
    post = Post.find(params[:id])

    # if the post.user id is the same as the current user id, then pass all actions as true and
    # exit out.  Machine here thinks (if not the same user id), "I am a different id.
    # and am exiting loop and headed to the next bit of information"
    return true if post.user == current_user

    # The user was not the current user (see above), so what user are you?
    # If the destroy action is generated, the post.user id will need to match a
    # moderator user id of 2 or an admin id of 1, else redirect back to post with directed error
    if action == 'destroy' && (post.user == !current_user || !current_user.admin?)
      flash[:alert] = 'You must be an admin to do that'
      redirect_to [post.topic, post]
    # same idea as destroy (above), except for the 'update' action
    elsif action == 'update' && !(current_user.moderator? || current_user.admin?)
      flash[:alert] = 'You must be an admin or a moderator to do that'
      redirect_to [post.topic, post]
    end
  end
end
