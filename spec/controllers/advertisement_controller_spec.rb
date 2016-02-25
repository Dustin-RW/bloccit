require 'rails_helper'
require 'random_data'

RSpec.describe AdvertisementController, type: :controller do

  let (:my_add) { Advertisement.create!( title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_number)}

#======================================================================
  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end


    it "assigns [my_ad] to @advertisements" do
      get :index

      expect(assigns(:advertisements)).to eq([my_add])
    end

  end
#======================================================================
  describe "GET show" do
    it "returns http success" do
      get :show, {id: my_add.id}

      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_add.id}

      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, {id: my_add.id}

      expect(assigns(:advertisement)).to eq(my_add)
    end

  end

#======================================================================
  describe "GET new" do
    it "returns http success" do
      get :new

      expect(response).to have_http_status(:success)
    end

    it "renders the #view" do
      get :new

      expect(response).to render_template :new
    end

    it "instantiates @advertisement" do
      get :new

      expect(assigns(:advertisement)).not_to be_nil
    end


  end
#======================================================================
#  describe "GET #create" do
#    it "returns http success" do
#      get :create
#      expect(response).to have_http_status(:success)
#    end
#  end
end
