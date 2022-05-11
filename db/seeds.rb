require 'faker'

user_return = []

for x in 1..50 do
  temp_name = Faker::Name.name
  username = temp_name.split(" ").join("").downcase
  email = "#{username}@gmail.com"
  user_return.push({
    name: temp_name,
    email: email,
    username: username,
    member: Faker::Boolean.boolean
  })
end
users = User.create(user_return)
puts "Created #{User.count} users"


100.times do
  Post.create(
    user_id: rand(1..User.count),
    title:  Faker::Hipster.sentence(word_count: 3).titleize,
    body: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4)
  )
end
puts "Created #{Post.count} Posts"


100.times do
  Comment.create(
    user_id: rand(1..User.count),
    post_id: rand(1..Post.count),
    body: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4)
  )
end
puts "Created #{Comment.count} Comments"