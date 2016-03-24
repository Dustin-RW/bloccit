require "random_data"

5.times do

  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end

users = User.all

admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

moderator = User.create!(
  name: 'Moderator User',
  email: 'moderator@example.com',
  password: 'helloworld',
  role: 'moderator'
)

member = User.create!(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)
#=============================================

15.times do

  Topic.create!(
  name: RandomData.random_sentence,
  description: RandomData.random_paragraph
  )

end

topics = Topic.all

#=============================================

50.times do

  post = Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
    )

  # update the time a post was created.  This makes our seeded data
  # more realistic and will allow us to see our ranking algorithm
  # in action
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)

  # we create between one and five votes for each post.  [-1, 1].sample
  # randomly creates either an up vote or a down vote
  rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }


end

  unique_post = Post.find_or_create_by(
    title: "Unique Title Here",
    body: "Here is the unique body"
    )

posts = Post.all

#=============================================

100.times do

  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
    )
  end

  Comment.find_or_create_by(
    post: unique_post,
    body: "This is my unique comment"
  )

#=============================================

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
