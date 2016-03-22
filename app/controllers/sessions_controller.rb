class SessionsController < ApplicationController
  def new
  end

  def create
    # we search the database for a user with the specified email address in the
    # params hash. We use downcase to normalize the email address since the
    # addresses stored in the database are stored as lowercase strings.
    # User.find_by email places all of found users information into user
    # for find_by method, see: http://guides.rubyonrails.org/active_record_querying.html
    user = User.find_by(email: params[:session][:email].downcase)

    # we verify here that the user is not nil (since the machine will read left to right)
    # and the password specified in the params hash matches the specified password
    # authenticate is from bcrypt and has_secure password.  **see: http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
    if user && user.authenticate(params[:session][:password])
      # method created within SessionHelper and passed to ApplicationHelper
      # so all controllers can access current_user
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}"
      redirect_to root_path
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    destroy_session(current_user)

    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_path
  end
end
