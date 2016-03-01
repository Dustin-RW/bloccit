class SponsoredPostsController < ApplicationController
  def show

    @topic = Topic.find(params[:topic_id])
    @sponsoredpost = SponsoredPost.find(params[:id])

  end

  def new



  end

  def edit
  end
end
