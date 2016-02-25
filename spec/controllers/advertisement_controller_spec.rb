require 'rails_helper'
require 'random_data'

RSpec.describe AdvertisementController, type: :controller do

  let (:my_ad) { Advertisement.create!( title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_number)}

#======================================================================
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end


    it "assigns [my_ad] to @advertisements" do
      get :index

      expect(assigns(:advertisements)).to eq([my_ad])
    end
  end
#======================================================================
  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

#  describe "GET #new" do
#    it "returns http success" do
#      get :new
#      expect(response).to have_http_status(:success)
#    end
#  end

#  describe "GET #create" do
#    it "returns http success" do
#      get :create
#      expect(response).to have_http_status(:success)
#    end
#  end

end
