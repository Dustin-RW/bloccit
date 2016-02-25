class AdvertisementController < ApplicationController

  def index

    @advertisements = Advertisement.all

  end

  def show

    @advertisement = Advertisement.find(params[:id])

  end

  def new

    @advertisement = Advertisement.new

  end

  def create
  end
end
