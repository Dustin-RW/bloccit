module PostsHelper

  def user_is_authorized_for_posts?(post)
    current_user && (current_user == post.user || current_user.admin?)
  end

  def post_moderator?(post)
    current_user.moderator?
  end

end
