module UsersHelper

  def posts_empty?(user)

    unless user.posts.count > 0
      return true
    end

  end

  def comments_empty?(user)

    unless user.comments.count > 0
      return true
    end

  end

end
