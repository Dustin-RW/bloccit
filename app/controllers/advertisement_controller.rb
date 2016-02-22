class AdvertisementController < ApplicationController

  def index

    @advertisements = Advertisement.all

  end

  def show
  end

  def new

    #@advertisements = Advertisement.new

  end

  def create
  end
end
