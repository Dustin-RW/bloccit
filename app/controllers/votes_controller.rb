class VotesController < ApplicationController
  # require a user to be signed in, see Application controller
  # basically, unless you are a current_user, buh-bye
  before_action :require_sign_in

  def up_vote
    update_vote(1)
  end

  def down_vote
    update_vote(-1)
  end

  private

  def update_vote(new_value)
    # pass in post id and set it to @post
    @post = Post.find(params[:post_id])
    # @vote = the current_user and its first vote?
    @vote = @post.votes.where(user_id: current_user.id).first
    # No idea what this is attributing to
    if @vote
      @vote.update_attribute(:value, new_value)
    else
      @vote = current_user.votes.create(value: new_value, post: @post)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
