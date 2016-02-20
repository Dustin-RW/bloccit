class PostsController < ApplicationController
  def index

    @posts = Posts.all

  end

  def show
  end

  def new
  end

  def edit
  end
end
