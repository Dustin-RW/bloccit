
Bloccit:  
=============
a Reddit replica to teach the fundamentals of web development and Rails.

**As a user:**

**Guest:** can view topics, but will need to sign up to create his/her own.  No other functionality.

**Signed in User:** can view all public topics and their own _private_ topics.  Only allowed to delete his/or her topics.

**Admin user:** navigate anywhere, able to view all public and private content, allowed to edit an delete any topic.

* **rake db:reset** in console(cmd) to re-seed data before running `rails s`

* **see seeds.rb** for login in credentials (ex. username: _admin@example.com_ password: _helloworld_)

**Note:** for some reason needed to change folders for `rails s` to run correctly without receiving "helper error."  If encounter same issue, see http://stackoverflow.com/questions/27884908/rails-abstractcontrollerhelpersmissinghelpererror-missing-helper-file-app (11/15/2016)
