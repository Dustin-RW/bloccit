class SponsoredPostsController < ApplicationController
  def show

    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.find(params[:id])

  end

  def new

    @sponsored_post = SponsoredPost.new

  end

  def edit
  end
end
