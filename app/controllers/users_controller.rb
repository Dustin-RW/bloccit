# crafted by HTML
class UsersController < ApplicationController
  def confirm
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # we create a new user with new and then set the corresponding attributes from the params hash
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Bloccit #{@user.name}"
      create_session(@user)
      redirect_to root_path
    else
      flash[:alert] = 'There was an error creating your account.  Please try again'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)
  end
end
