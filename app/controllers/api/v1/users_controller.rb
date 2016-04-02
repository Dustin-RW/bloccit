class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user
  before_action :authorize_user

  # defined show action for our API UsersController action
  #  Unlike our non-API UsersController, this show action renders the user
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
end
