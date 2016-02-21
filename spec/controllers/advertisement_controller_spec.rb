require 'rails_helper'
require 'random_data'

RSpec.describe AdvertisementController, type: :controller do

  let (:my_add) do
    Advertisement.create(id: 1, title: RandomData.random_sentence,
    copy: RandomData.random_paragraph, price: 99)
  end


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  it "assigns (my_ad) to @advertisements" do
    get :index

    expect(assigns(:advertisement)).to eq([my_ad])

  end
#  describe "GET #show" do
#    it "returns http success" do
#      get :show
#      expect(response).to have_http_status(:success)
#    end
#  end

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
