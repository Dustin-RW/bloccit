class TopicsController < ApplicationController
  # see private methods at bottom

  # require_sign_in method found in application_controller.rb.  Method runs before any action
  # within topics controller except within index and show ( ...unless current_user)
  # before_action see(http://guides.rubyonrails.org/action_controller_overview.html)
  before_action :require_sign_in, except: [:index, :show]
  # authorize_user method within Topic Controller (private).  Before any action, run authorize_user
  # method unless its topics index action or show action
  before_action :authorize_user, except: [:index, :show]

  def index
    @topics = Topic.all
  end

  #====================================================================
  def show
    @topic = Topic.find(params[:id])
  end

  #====================================================================
  def new
    @topic = Topic.new
  end

  #====================================================================
  def create
    # for topic_params information, see PostController post_param notes
    @topic = Topic.new(topic_params)

    if @topic.save
      @topic.labels = Label.update_labels(params[:topic][:labels])
      redirect_to @topic, notice: 'Topic was saved successfully'
    else
      flash.now[:alert] = 'Error creating topic.  Please try again'
      render :new
    end
  end

  #====================================================================
  def edit
    @topic = Topic.find(params[:id])
  end
  #====================================================================

  def update
    @topic = Topic.find(params[:id])
    # for topic_params information, see PostController post_param notes

    @topic.assign_attributes(topic_params)

    if @topic.save
      @topic.labels = Label.update_labels(params[:topic][:labels])
      flash[:notice] = 'Topic was updated'
      redirect_to @topic
    else
      flash[:alert] = 'Error saving topic. Please try again'
    end
  end
  #==================================================================

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully"
      redirect_to action: :index
    else
      flash.now[:alert] = 'There was an error deleting the topic'
      render :show
    end
  end

  private

  # for topic_params information, see PostController post_param notes
  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  # unless current user is an admin?, flash alert (see above: before_action)
  def authorize_user
    unless current_user.moderator? || current_user.admin?
      flash[:alert] = 'You must be an admin to do that'
      redirect_to topics_path
    end
  end

  def return_to_index_if_moderator
    unless current_user.admin?
      flash[:alert] = 'You must be an admin to do that'
      redirect_to topics_path
  end
  end
end
