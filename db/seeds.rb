require 'faker'

user_return = []

for x in 1..10 do
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


25.times do
  Post.create(
    user_id: rand(1..User.count),
    title:  Faker::Hipster.sentence(word_count: 3).titleize,
    body: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4)
  )
end
puts "Created #{Post.count} Posts"

Tag.create([
    {tag: 'Nature', post_id: 1},
    {tag: 'School', post_id: 2},
    {tag: 'Nursing', post_id: 4},
    {tag: 'Education', post_id: 2},
    {tag: 'Handy', post_id: 6},
    {tag: 'Sports', post_id: 8},
    {tag: 'Business', post_id: 9},
    {tag: 'Tech', post_id: 11},
    {tag: 'Trees', post_id: 1},
    {tag: 'Hobby', post_id: 5}        
])
puts "Created #{Tag.count} Tags"


50.times do
  Comment.create(
    user_id: rand(1..User.count),
    post_id: rand(1..Post.count),
    body: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4)
  )
end
puts "Created #{Comment.count} Comments"