require "random_data"

15.times do

  Topic.create!(
  name: RandomData.random_sentence,
  description: RandomData.random_paragraph
  )

end

topics = Topic.all

50.times do

  Post.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
    )

end

  unique_post = Post.find_or_create_by(
    title: "Unique Title Here",
    body: "Here is the unique body"
    )

posts = Post.all

25.times do

  SponsoredPost.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: RandomData.random_number

  )
end

sponsored_posts = SponsoredPost.all

100.times do

  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
    )
  end

  Comment.find_or_create_by(
    post: unique_post,
    body: "This is my unique comment"
  )

puts "Seed finished"
puts "#{Topic.count} Topics created"
puts "#{Post.count} posts created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Comment.count} comments created"
