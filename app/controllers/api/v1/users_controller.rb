class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user
  before_action :authorize_user

  # defined show action for our API UsersController action
  # Unlike our non-API UsersController, this show action renders the user
  # object it finds as JSON and returns an HTTP status code of 200 (success)
  def show
    user = User.find(params[:id])

    render json: user.to_json, status: 200
  end

  # renders all Users as json
  def index
    users = User.all

    render json: users.to_json, status: 200
  end

  def update

    user = User.find(params[:id])
    # we attempt to update_attributes on the given user
    if user.update_attributes(user_params)
      render json: user.to_json, status: 200
    else
      render json: {error: "User update failed", status: 400}, status: 400
    end
    
  end

  def create

    user = User.new(user_params)

    if user.valid?
      user.save!
      render json: user.to_json, status: 201
    else
      render json: {error: "User is invalid", status: 400}, status: 400
    end

  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

end
