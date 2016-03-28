class FavoriteMailer < ApplicationMailer
  # This sets the default from for all emails sent from FavoriteMailer
  default from: "dustinwaggoner@comcast.net"

  def new_comment(user, post, comment)

    # we set three different headers to enable conversation threading in different email clients
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @comment = comment

    # mail method takes a hash of mail-relevant information - the subject the to
    # address, the from (we're using the default), and any cc or bcc information
    # - and prepares the email to be sent
    mail(to: user.email, subject: "New comment on #{post.title}")

  end
end
