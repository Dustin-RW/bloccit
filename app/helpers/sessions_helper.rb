module SessionsHelper
  # create session sets user_id on the session object to user.id
  def create_session(user)
    # changes the session id within the server
    session[:user_id] = user.id
  end

  # we destroy the session of user.id by resetting it to nil
  def destroy_session(user)
    session[:user_id] = nil
  end

  # current_user returns the current user of the application
  # uses the find_by method of User to identify the id passed as the user
  def current_user
    User.find_by(id: session[:user_id])
  end
end
