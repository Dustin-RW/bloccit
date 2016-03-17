module CommentsHelper

  def user_is_authorized_for_comment_via_post?(comment)
    current_user && (current_user = comment.user || current_user.admin?)
  end

  def user_is_authorized_for_comment_via_topic?(comment)
    current_user && (current_user = comment.user || current_user.admin?)
  end



end
