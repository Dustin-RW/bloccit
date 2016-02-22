require "random_data"

50.times do

  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
    )

end

  unique_post = Post.find_or_create_by(
    title: "Unique Title Here",
    body: "Here is the unique body"
    )

posts = Post.all

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


100.times do

  Question.create!(
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph,
  resolved: false
  )

end




puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Question.count} questions created"
