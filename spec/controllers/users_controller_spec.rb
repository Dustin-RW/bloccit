require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # instance created for a new_user within User Controller spec
  let(:new_user_attributes) do
    {
      name: 'BlocHead',
      email: 'blochead@bloc.io',
      password: 'blochead',
      password_confirmation: 'blochead'
    }
  end
  #========================================================
  # describe "Post confirm" do

  # it "returns http success" do
  # expect(response).to have_http_status(:success)
  # end

  # it "renders #confirm" do
  # get :confirm, user: new_user_attributes

  # expect(response).to render_template :confirm
  # end

  # it "assigns new_user_attributes to @user" do
  # get :confirm, user: new_user_attributes

  # expect(assigns(:user)).to eq(new_user_attributes)
  # end
  # end
  #========================================================
  # what happens when the new action of user is called
  describe 'GET new' do
    it 'returns http success' do
      # tell rspec to use get new action
      get :new
      # expect that the new action has success
      expect(response).to have_http_status(:success)
    end

    it 'initiates a new User' do
      get :new
      # expects the instance of user, hence :user (aka @user within controller)
      # not to be nil
      expect(assigns(:user)).to_not be_nil
    end
  end
  #========================================================
  describe 'POST create' do
    it 'returns an http redirect' do
      # using post create action with instance of spec as a test
      post :create, user: new_user_attributes
      # expect the response to redirect
      expect(response).to have_http_status(:redirect)
    end

    it 'creates a new user' do
      # expect after post create, that User count increases by 1
      expect { post :create, user: new_user_attributes }.to change(User, :count).by(1)
    end

    it 'sets user name properly' do
      post :create, user: new_user_attributes

      expect(assigns(:user).name).to eq new_user_attributes[:name]
    end

    it 'sets user email properly' do
      post :create, user: new_user_attributes

      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end

    it 'sets user password properly' do
      post :create, user: new_user_attributes

      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end

    it 'sets user password_confirmation properly' do
      post :create, user: new_user_attributes

      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end

    it 'logs the user in after sign up' do
      post :create, user: new_user_attributes

      expect(session[:user_id]).to eq assigns(:user).id
    end
  end
end
